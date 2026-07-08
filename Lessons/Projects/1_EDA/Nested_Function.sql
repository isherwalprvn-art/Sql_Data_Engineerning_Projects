
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





