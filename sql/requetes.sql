-- 1. Accidents par heure
SELECT heure, COUNT(*) AS nb_accidents
FROM caracteristiques
GROUP BY heure
ORDER BY heure;

-- 2. Accidents par mois
SELECT mois, COUNT(*) AS nb_accidents
FROM caracteristiques
GROUP BY mois
ORDER BY mois;

-- 3. Répartition par gravité
SELECT gravite,
       COUNT(*) AS nb_usagers,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM usagers), 1) AS pourcentage
FROM usagers
GROUP BY gravite
ORDER BY nb_usagers DESC;

-- 4. Taux de tués selon la luminosité (jointure)
SELECT c.luminosite,
       COUNT(*) AS nb_usagers,
       SUM(u.grav = 2) AS nb_tues,
       ROUND(100.0 * SUM(u.grav = 2) / COUNT(*), 2) AS taux_tues_pct
FROM caracteristiques c
JOIN usagers u ON c.Num_Acc = u.Num_Acc
WHERE c.luminosite IS NOT NULL
GROUP BY c.luminosite
ORDER BY taux_tues_pct DESC;

-- 5. Taux de tués selon le type de route
SELECT l.type_route,
       COUNT(*) AS nb_usagers,
       SUM(u.grav = 2) AS nb_tues,
       ROUND(100.0 * SUM(u.grav = 2) / COUNT(*), 2) AS taux_tues_pct
FROM lieux l
JOIN usagers u ON l.Num_Acc = u.Num_Acc
WHERE l.type_route IS NOT NULL
GROUP BY l.type_route
ORDER BY taux_tues_pct DESC;

-- 6. Départements avec plus de 500 accidents
SELECT dep, COUNT(*) AS nb_accidents
FROM caracteristiques
GROUP BY dep
HAVING COUNT(*) > 500
ORDER BY nb_accidents DESC
LIMIT 10;

-- 7. Taux de tués selon la météo
SELECT c.meteo,
       COUNT(*) AS nb_usagers,
       ROUND(100.0 * SUM(u.grav = 2) / COUNT(*), 2) AS taux_tues_pct
FROM caracteristiques c
JOIN usagers u ON c.Num_Acc = u.Num_Acc
WHERE c.meteo IS NOT NULL
GROUP BY c.meteo
ORDER BY taux_tues_pct DESC;