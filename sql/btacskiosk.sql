[getOfficeList]
SELECT * FROM departments WHERE 1=1 
${filter}
order by deptname

[getEmployeeList]
SELECT
dbo.USERINFO.USERID,
dbo.USERINFO.NAME,
dbo.USERINFO.TITLE,
dbo.USERINFO.DEFAULTDEPTID,
dbo.USERINFO.BADGENUMBER
FROM
dbo.USERINFO
WHERE dbo.USERINFO.DEFAULTDEPTID = $P{deptid}
ORDER BY
dbo.USERINFO.NAME ASC

[getSignatoryList]
SELECT *,NAME + ':' + [POSITION] AS x FROM Signatory ORDER BY NAME

[getReconciliationItems]
SET DATEFIRST 1
SELECT * FROM dbo.GetDTRReconciliationItem($P{selectedmonth},$P{currentyear},$P{userid}) 
WHERE (DateLogin IS NULL OR DateLogout IS NULL) AND UNDERTIME > 0 AND StartTime < CAST(CAST(GETDATE() AS DATE) AS DATETIME);

[getLeaveClass]
SELECT * FROM LeaveClass WHERE STATE = 'APPROVED';

[getPenaltyList]
SELECT * FROM Penalty ORDER BY id;

[findLeaveClass]
SELECT * FROM LeaveClass WHERE LeaveName = $P{leavename};

[findReconciliationCount]
SELECT COUNT(*) AS ftlcount  FROM CHECKINOUT
WHERE USERID = $P{USERID}
AND SENSORID IS NULL
AND YEAR(CHECKTIME) = $P{YEAR}
AND MONTH(CHECKTIME) = $P{MONTH}
AND Memoinfo = 'SYSTEM FORGOT TO LOG'

[findReconciliationItem]
SET DATEFIRST 1
SELECT * FROM dbo.GetDTRReconciliationItem($P{MONTH},$P{YEAR},$P{USERID}) 
WHERE datestart = $P{DATESTART} AND dateend = $P{DATEEND}