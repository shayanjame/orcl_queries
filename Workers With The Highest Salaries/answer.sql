select worker_title
from worker
         inner join title on worker_id = worker_ref_id
where salary >= ALL (select salary
                     from worker);

WITH cte_quantity AS
             (select max(SALARY) as maxSalary from WORKER)
select worker_title
from worker
         inner join title on worker.WORKER_ID = title.worker_ref_id
   , cte_quantity
where SALARY >= maxSalary