USE SQL100Days;

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;




WITH team_cte AS(SELECT Team_1 AS team_name ,
       CASE WHEN Team_1 = Winner THEN  1 ELSE 0 END AS win_flag
FROM icc_world_cup

UNION ALL

SELECT Team_2 AS team_name ,
       CASE WHEN Team_2 = Winner THEN  1 ELSE 0 END AS win_flag
FROM icc_world_cup)
SELECT team_name,
       count(1) AS match_played,
       SUM(win_flag) AS matches_won,
       COUNT(1) - SUM(win_flag) AS matches_lost
FROM team_cte
GROUP BY team_name
ORDER BY matches_won DESC;