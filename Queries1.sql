---create a join table
select * from Absenteeism_at_work as a
left join compensation as b
on a.id = b.id
left join reasons as c
on a.reason_for_absence = c.number;

----find the healthiest emplyees for the bonus
select * from Absenteeism_at_work
where social_drinker = 0 and social_smoker=0 and body_mass_index < 25
and Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism_at_work);

---compensation rate increase for non-smokers / budget $983,221 so .68 increase per hour/ $1.414.4 per year
select count(*) from Absenteeism_at_work
where social_smoker=0 ;

---optimize the query

select a.id, c.reason, Month_of_absence,
case when Month_of_absence in (12,1,2) then 'Winter'
     when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Fall'
	 else 'Unknown' end as Season_names,
Body_mass_index,
case when Body_mass_index < 18.5 then 'UnderWeight'
     when Body_mass_index between 18.5 and 25 then 'Healthy weight'
     when Body_mass_index between 26 and 30 then 'OverWeight'
     when Body_mass_index > 30 then 'Obese'
     else 'Unknown' end as BMI_Category,
Day_of_the_week, Transportation_expense, Education, Son, Social_smoker,
Social_drinker, Pet, Disciplinary_failure, Age, Work_load_Average_day, 
Absenteeism_time_in_hours from Absenteeism_at_work as a
left join compensation as b
on a.id = b.id
left join reasons as c
on a.reason_for_absence = c.number;

