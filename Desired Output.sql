use ig_clone;

select*from users;

# Rewarding Most Loyal Users:
select*from users
order by created_at 
limit 5;

select*from photos;

# Remind Inactive Users to Start Posting:
select users.id, users.username from users
left join photos
on users.id = photos.user_id
where photos.user_id is null;

# Declaring Contest Winner:
select users.username, users.id, users.created_at, photos.image_url, photos.id, 
Count(*) as like_count from users
Join photos on users.id = photos.user_id
Join likes on photos.id = likes.photo_id
group by users.id, photos.id
order by like_count desc
limit 1;

# Hashtag Research:
SELECT tags.tag_name,
COUNT(*) AS total
FROM photo_tags
Inner JOIN tags
ON photo_tags.tag_id = tags.id
GROUP BY tags.tag_name
ORDER BY total DESC
LIMIT 5;

# Launch Ad Campaign:
SELECT DAYNAME(created_at) As registration_day,
COUNT(*) AS user_count
FROM users
GROUP BY registration_day
ORDER BY user_count DESC
LIMIT 2;

# User Engagement:
SELECT (SELECT Count(id)
        FROM   photos) / (SELECT Count(DISTINCT user_id)
                          FROM   photos) AS Average_posts_per_User,
       (SELECT Count(id)
        FROM   photos) / (SELECT Count(id)
                          FROM   users)  AS Ratio_of_Total_Posts_to_Total_Users; 

# Bots and Fake Accounts:
SELECT username, Count(*) AS num_likes
FROM users
INNER JOIN likes
ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT Count(*)FROM photos);