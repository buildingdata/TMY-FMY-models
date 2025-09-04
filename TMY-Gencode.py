"""
Script for selecting Typical Meteorological Year (TMY) using Sandia (TMY2) 
and TMY3 methods. The code evaluates long-term weather station data 
to identify representative months and years based on statistical 
comparisons of key climatic parameters.

Core workflow:
1. Identify stations with at least 30 years of continuous data. 
   Apply the Sandia method (TMY2) with modifications:
   - Replace dew point temperature with relative humidity (4/24)
   - Replace maximum wind speed with average wind speed (2/24)
   - Replace direct solar radiation with daily total radiation (12/24)

2. Select stations with available maximum wind speed data. 
   Recalculate using both average wind speed (2/24) and maximum wind speed (2/24), 
   and compare results with step (1).

3. (Reserved for further experiments)

4. On top of step (3), identify stations with direct solar radiation records. 
   Apply TMY3 weighting (with direct radiation included) and compare results.
"""

# --------------------------------------------------------------------
# Statistical procedure for FS calculation (empirical CDF comparison):
# 1. Extract dry-bulb temperature for all available years.
# 2. Sort all January values from smallest to largest.
# 3. Sort each year’s January values in the same manner.
# 4. Construct the cumulative distribution function (CDF):
#    - Count the frequency of each unique temperature value.
#    - Compute cumulative probability using (cumulative_count - 0.5)/N.
# 5. Plot annual CDFs for comparison.
# 6. Plot the long-term CDF as a reference.
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# Parameter weights for TMY selection
#
# TMY3 (NSRDB standard):
#   Max dry-bulb temperature    1/20
#   Min dry-bulb temperature    1/20
#   Mean dry-bulb temperature   2/20
#   Max dew point temperature   1/20
#   Min dew point temperature   1/20
#   Mean dew point temperature  2/20
#   Max wind speed              1/20
#   Mean wind speed             1/20
#   Global horizontal radiation 5/20
#   Direct normal radiation     5/20
#
# Sandia method (TMY2 standard):
#   Daily max dry-bulb temp     1/24
#   Daily min dry-bulb temp     1/24
#   Daily mean dry-bulb temp    2/24
#   Daily mean dew point temp   4/24
#   Daily max wind speed        2/24
#   Daily mean wind speed       2/24
#   Daily mean solar radiation 12/24
#
# Modified TMY2 for stations without solar radiation data:
#   Daily max temperature       1/24
#   Daily min temperature       1/24
#   Daily mean temperature      2/24
#   Daily mean relative humidity 4/24
#   Extreme wind speed          2/24
#   Mean wind speed             2/24
#   Sunshine duration           12/24
#
# Modified TMY2 for stations with global radiation:
#   Daily max temperature       1/24
#   Daily min temperature       1/24
#   Daily mean temperature      2/24
#   Mean relative humidity      4/24
#   Max wind speed              2/24
#   Mean wind speed             2/24
#   Global solar radiation      12/24
#
# TMY3 (for stations with both global and direct radiation):
#   Daily max temperature       1/20
#   Daily min temperature       1/20
#   Daily mean temperature      2/20
#   Mean relative humidity      4/20
#   Max wind speed              1/20
#   Mean wind speed             1/20
#   Global solar radiation      5/20
#   Direct solar radiation      5/20
# --------------------------------------------------------------------


import matplotlib
import matplotlib.pyplot as pl
import numpy as np
import calendar
import pymysql as p
from itertools import chain
import sys

# Redirect output and error logs to file
foutput = open("output1.2_total_solar_radiation.txt", "w+")
sys.stdout = foutput
sys.stderr = foutput


# --------------------------------------------------------------------
# Database query utilities
# --------------------------------------------------------------------

def selYearNum(StationNo):
    """
    Return a list of distinct years of data available for a given station.
    """
    YearNumsql = "select distinct `year` from `weatherdata135all`.`135daySOLARzone` where `StationNo`={}".format('%d'%(StationNo))
    cur.execute(YearNumsql)
    YearNumret=cur.fetchall()
    return YearNumret


def selStationNoList():
    """
    Return list of stations with at least 30 years of data 
    (i.e., at least 360 unique month records).
    """
    StationNoListsql = "select distinct `StationNo` from `weatherdata135all`.`135daySOLARzone` group by StationNo having count(distinct(concat(year,month)))>=360"
    cur.execute(StationNoListsql)
    StationNoListret=cur.fetchall()
    return StationNoListret


def seleachyear(year,month,StationNo,parameter):
    """
    Retrieve daily values of a given parameter for a station in a specific year and month.
    Results are sorted by parameter value.
    """
    yue_sql =  "SELECT {}  FROM `weatherdata135all`.`135daySOLARzone` where `StationNo`={} and `year`= {} and`month`={} and {} < 30000 order by {}".format('%s'%(parameter),'%d'%(StationNo),'%d'%(year),'%d'%(month),'%s'%(parameter),'%s'%(parameter))
    cur.execute(yue_sql)
    yueret=cur.fetchall()
    return yueret


def sellongterm(month,StationNo,beginYear,parameter):
    """
    Retrieve long-term values of a parameter for a given month 
    starting from beginYear. Values sorted by parameter value.
    """
    suoyounian_sql = "SELECT {} FROM `weatherdata135all`.`135daySOLARzone` where `StationNo`={} and `month`={} and {} < 30000 and `year`>={} order by {}" .format('%s'%(parameter),'%d'%(StationNo),'%d'%(month),'%s'%(parameter),'%d'%(beginYear),'%s'%(parameter));
    cur.execute(suoyounian_sql)
    suoyouret=cur.fetchall()
    return suoyouret


# --------------------------------------------------------------------
# Statistical helper functions
# --------------------------------------------------------------------

def TFrequency(list):
    """
    Compute frequency of each unique value in the list.
    Return:
        Tlist - unique values
        Flist - frequency counts
    """
    each=list[0]
    Tlist=[list[0]]
    Flist=[]
    n=0
    for i in range(len(list)):
        if(list[i]==each):
            n=n+1
        else:
            Flist.append(n)
            Tlist.append(list[i])
            each=list[i]
            n=1
    Flist.append(n)
    return(Tlist,Flist)


def Acc(list):
    """
    Compute cumulative frequency from a frequency list.
    """
    Alist=[]
    n=0
    for i in range(len(list)):
        Alist.append(list[i]+n)
        n=Alist[i]
    return Alist


def CDF(list):
    """
    Compute empirical cumulative distribution function (CDF)
    from cumulative frequencies.
    """
    CDFlist=[]
    for i in range(len(list)):
        tmp = (list[i] - 0.5) / list[-1];
        CDFlist.append(tmp)
    return CDFlist


def selItemPerMonthYear(year,month,StationNo,parameter):
    """
    Retrieve daily values of a parameter for a given month and year,
    ordered by day.
    """
    Item_sql = "SELECT {} FROM `weatherdata135all`.`135daySOLARzone` where `StationNo`={} and `month`={} and `year`={} and {} < 30000 order by `day`" .format('%s'%(parameter),'%d'%(StationNo),'%d'%(month),'%d'%(year),'%s'%(parameter));
    cur.execute(Item_sql)
    Itemret=cur.fetchall()
    return Itemret


def DayCount(year,month):
    """
    Return number of days in a given month of a given year.
    Leap year logic included.
    """
    if month in [1,3,5,7,8,10,12]:
        return 31
    elif month in [4,6,9,11]:
        return 30
    elif month == 2:
        if year % 4 == 0:
            return 29
        else:
            return 28
    else:
        print("Invalid month/year input")


# --------------------------------------------------------------------
# FS and WS computation
# --------------------------------------------------------------------

def EachParameterFScount(StationNo, YearNumList, parameter):
    """
    Compute the Finkelstein-Schafer (FS) statistic for each year 
    relative to the long-term distribution of a given parameter.

    Returns:
        monthFS - FS values per month for all years
    """
    TMMTemperature = []
    minTemperatureFSlist = []
    monthFS = []
    for i in range(12):
        month = i+1

        # Long-term parameter distribution from baseline year
        longtermT = sellongterm(month,StationNo,YearNumList[0],parameter)

        # CDF of long-term distribution
        (TlistLong,FlistLong) = TFrequency(longtermT)
        AlistLong=Acc(FlistLong)
        CDFlistLong=CDF(AlistLong)

        FSlist = []

        # Compute FS statistic for each year
        for i in range(YearNum):
            everyYearT = seleachyear(YearNumList[i], month, StationNo, parameter)
            if (everyYearT):
                (TlistEach, FlistEach) = TFrequency(everyYearT)
                AlistEach = Acc(FlistEach)
                CDFlistEach = CDF(AlistEach)
                sum=0
                # Sum of absolute differences in CDFs
                for j in range(len(CDFlistEach)):
                    index=TlistLong.index(TlistEach[j])
                    sum=sum+abs(CDFlistLong[index]-CDFlistEach[j])
                FSlist.append(sum/len(CDFlistEach))
            else:
                # Handle missing data
                print(YearNumList[i],'year',month,'is missing')
                FSlist.append(1)
                continue;

        minFSindex = FSlist.index(min(FSlist))
        minTemperatureFS = FSlist[minFSindex]
        minTemperatureFSlist.append(minTemperatureFS)
        TMMTemperature.append(YearNumList[minFSindex])

        if(month==12):
            print('TMMparameter:', parameter)
            print(TMMTemperature)
            print("======")
        monthFS.append(FSlist)
    return monthFS


def WSCount(FSlistTemAvg,FSlistTemMax,FSlistTemMin,FSlistRHAvg,FSlistWindSpeedAvg,FSlistSunHours):
    """
    Compute weighted sum (WS) of FS statistics 
    across selected climatic parameters per TMY2 weighting scheme.
    """
    WSlist=[]
    for i in range(12):
        WSitem=[]
        for j in range(len(FSlistTemAvg[i])):
            WSitem.append(FSlistTemAvg[i][j]*2/24 + 
                          FSlistTemMax[i][j]*1/24 + 
                          FSlistTemMin[i][j]*1/24 + 
                          FSlistRHAvg[i][j]*4/24 + 
                          FSlistWindSpeedAvg[i][j]*4/24 + 
                          FSlistSunHours[i][j]*12/24)
        WSlist.append(WSitem)
    return WSlist


def TMYlist(WSlist):
    """
    Identify the year with minimum WS value for each month.
    Returns list of typical meteorological months (TMM).
    """
    minWSlist = []
    TMMlist = []
    for i in range(12):
        minWSindex = WSlist[i].index(min(WSlist[i]))
        minWS = WSlist[i][minWSindex]
        minWSlist.append(minWS)
        TMMlist.append(YearNumList[minWSindex])
    return TMMlist


# --------------------------------------------------------------------
# Main program
# --------------------------------------------------------------------

# Open database connection
conn = p.connect(host="localhost",port=3306,user='root',passwd='12345678',db='weatherdata135all')
cur = conn.cursor()

StationNoList=selStationNoList()
print(StationNoList)
print(len(StationNoList))

f = open("/Users/wangshangyu/Documents/data/result/TMM11.2_total_solar_radiation.txt", "w+")
f.write("StationNo" + " " + "1" + " " + "2" + " " + "3" + " " + "4" + " " + "5" + " " + "6" + " " +
        "7" + " " + "8" + " " + "9" + " " + "10" + " " + "11" + " " + "12" + "\n")

for IndexS in range(len(StationNoList)):
    StationNo = StationNoList[IndexS][0]
    print(StationNo)

    # Retrieve available years
    YearNumListall = selYearNum(StationNo)
    # Select most recent 30 years
    YearNumList = YearNumListall[-30:]
    YearNum = len(YearNumList)

    # Compute FS values per parameter
    parameterTemAvg = 'avgtem'
    FSlistTemAvg = EachParameterFScount(StationNo, YearNumList, parameterTemAvg)

    parameterTemMax = 'maxtem'
    FSlistTemMax = EachParameterFScount(StationNo, YearNumList, parameterTemMax)

    parameterTemMin = 'mintem'
    FSlistTemMin = EachParameterFScount(StationNo, YearNumList, parameterTemMin)

    parameterRHAvg = 'rhu'
    FSlistRHAvg = EachParameterFScount(StationNo, YearNumList, parameterRHAvg)

    parameterWindSpeedAvg = 'avgwindspeed'
    FSlistWindSpeedAvg = EachParameterFScount(StationNo, YearNumList, parameterWindSpeedAvg)

    parameterSunHours = 'G'
    FSlistSunHours = EachParameterFScount(StationNo, YearNumList, parameterSunHours)

    WSlist = WSCount(FSlistTemAvg,FSlistTemMax,FSlistTemMin,FSlistRHAvg,FSlistWindSpeedAvg,FSlistSunHours)
    TMMlist = TMYlist(WSlist)

    print("TMM:")
    print(TMMlist)
    print("********************")

    # Save results
    f.write("%d"%StationNo)
    for Index in range(len(TMMlist)):
        f.write(" " + "%d"%TMMlist[Index][0])
    f.write("\n")

conn.commit()
cur.close()
conn.close()

f.close()
foutput.close()
