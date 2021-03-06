USE salary_of_employees;
SELECT 
	SUM(sub_query.`Начислено`) as `Общий фонд заработной платы`,
    SUM(sub_query.`Подоходный налог`) as `Подоходный налог`,
    SUM(sub_query.`Отчисления в социальные фонды`) as `Отчисления в социальные фонды`
FROM (
	SELECT 
		sotr.*, r_list.`Дата формирования`,
		(nach.`Отпускная выплата`+ nach.`Больничная выплата` + nach.`Пособие за иждивенцев` + nach.`Зарплата` + nach.`Надбавка` + nach.`Премия`) as `Начислено`,
        (uderzh.`Подоходный налог`),
		(uderzh.`Отчисления в фонд обязательного медицинского страхования`) as `Отчисления в социальные фонды`
	FROM сотрудник sotr
	JOIN `расчетный лист` r_list ON sotr.`Табельный номер` = r_list.`Сотрудник_Табельный номер`
	JOIN `удержания` uderzh 
		ON uderzh.`Расчетный лист_Сотрудник_Табельный номер` = sotr.`Табельный номер` 
		AND uderzh.`Расчетный лист_Дата формирования` = r_list.`Дата формирования`
	JOIN `начисления` nach 
		ON nach.`Расчетный лист_Сотрудник_Табельный номер` = sotr.`Табельный номер` 
		AND nach.`Расчетный лист_Дата формирования` = r_list.`Дата формирования`
) as sub_query
WHERE sub_query.`Дата формирования` BETWEEN "2020-10-01" AND "2020-10-30";

