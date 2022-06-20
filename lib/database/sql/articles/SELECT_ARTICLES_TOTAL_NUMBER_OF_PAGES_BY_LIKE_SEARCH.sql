SELECT
  count(*) AS totalPages
FROM
  (
    SELECT
      a.id,
      a.user_id,
      a.title,
      a.letter_body,
      u.username,
      GROUP_CONCAT(c.name) AS category_name
    FROM
      articles as a 
      LEFT OUTER JOIN
        articles_category AS ac
      ON a.id = ac.articles_id
        LEFT OUTER JOIN
          category AS c
        ON ac.category_id = c.id
          LEFT OUTER JOIN
            users AS u
            ON a.user_id = u.id
    GROUP BY a.id
    HAVING concat(a.title, a.letter_body, u.username, IFNULL(category_name, "")) LIKE ?
      AND concat(a.title, a.letter_body, u.username, IFNULL(category_name, "")) LIKE ?
      AND concat(a.title, a.letter_body, u.username, IFNULL(category_name, "")) LIKE ?
      AND concat(a.title, a.letter_body, u.username, IFNULL(category_name, "")) LIKE ?
      AND concat(a.title, a.letter_body, u.username, IFNULL(category_name, "")) LIKE ?
    ORDER BY a.created_at DESC
  ) as tmp
