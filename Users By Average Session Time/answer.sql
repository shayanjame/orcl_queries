select user_id, (sum(session_time) * 1.0) / count(USER_ID) as session_time
from (with cte as (select USER_ID,
                          (max(case when action = 'page_load' then timestamp end) -
                           min(case when action = 'page_exit' then timestamp end)) AS session_time
                   from FACEBOOK_WEB_LOG
                   group by USER_ID, trunc(TIMESTAMP))
      select USER_ID,
             -extract(day from session_time) * 24 * 60 * 60 +
             -extract(hour from session_time) * 60 * 60 +
             -extract(minute from session_time) * 60 +
             -extract(second from session_time) AS session_time
      from cte)
where session_time is not null
group by user_id
