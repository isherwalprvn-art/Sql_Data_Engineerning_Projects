
--array Data Type
Select [1,2,3,4];

Select ['python','sql','r'];


with skills as (
    Select 'python' as skill
    Union ALL
    Select 'sql'
    Union ALL
    Select 'r'
), skills_array as (
    Select array_Agg(skill order by skill)  as skills 
    from skills) 
--Select * from  skills_array ;
Select 
 skills[1] as First_Skill,
 skills[2] as Second_Skill,
 skills[3] as Third_Skill
from skills_array;  


--struct Data Type

Select {skill:'python', type:'programming'};


with skill_struct as (
    Select
        struct_pack(
            skill:='python',
            type:='programming'

        ) as s
)

Select 
s.skill,
s.type
from skill_struct;



with skill_struct as (
    Select 'python' as skills, 'programming' as types
    Union ALL
    Select 'sql','query'
    Union ALL
    Select 'r','programming'
), skill_struct_pack as (
    Select 
    struct_pack(
        skill:= skills,
        type:= types) as s1

from skill_struct
    )
    select s1.skill,s1.type from skill_struct_pack; 

--Array of structs

with skill_struct as (
    Select 'python' as skills, 'programming' as types
    Union ALL
    Select 'sql','query'
    Union ALL
    Select 'r','programming'
), 
skill_struct_pack as (
    Select 
    struct_pack(
        skill:= skills,
        type:= types) as s1

from skill_struct
    ), 
skill_array_struct as (
    select 
    array_Agg(s1 order by s1.skill) as skills_array
    from skill_struct_pack)
Select

    skills_array[1].skill as First_skill,
    skills_array[1].type as First_type,
    skills_array[2].skill as Second_skill,
    skills_array[2].type as Second_type,
    skills_array[3].skill as Third_skill,
    skills_array[3].type as Third_type

 from skill_array_struct; 

 --JSON(Java Script Object Notation)
With raw_json_skill as (
    Select
        '{"skill":"python","type":"programming"}':: JSON As skill_json
)  
    Select 
    struct_pack(
        skill:= json_extract_string(skill_json,'$.skill'),
        type:= json_extract_string(skill_json,'$.type')
    )
    From raw_json_skill  ; 

-- Array Final Example 
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table.

Create Or Replace  Temp Table job_skills_array  As 
Select
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    array_Agg(sd.skills) As skill_array
 
 

From job_postings_fact jpf 
    Left Outer join skills_job_dim sjd on sjd.job_id=jpf.job_id
    Left Outer Join skills_dim sd on sd.skill_id=sjd.skill_id --7478801
    Group by All;--1615930


Select * from job_skills_array;--1615930




