# SQL_Project_ENGETO_Academy
My SQL Project by Engeto Academy

## **Zadání projektu**

Cílem projektu je získání přehledu o životní úrovní občanů v ČR a zodpovězení 5 definovaných výzkumných otázek, které adresují **dostupnost základních potravin široké veřejnosti**.

V rámci projektu jsou **připraveny robustní datové podklady**, ve kterých je možné vidět **porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období**.

Jako dodatečný materiál je připravena i tabulka s HDP, GINI koeficientem a populací **dalších evropských států** ve stejném období, jako primární přehled pro ČR.

**Datové sady, které byly v rámci projektu použity pro získání vhodného datového podkladu:**

## **Primární tabulky:**

`czechia_payroll` – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

`czechia_payroll_calculation` – Číselník kalkulací v tabulce mezd.

`czechia_payroll_industry_branch` – Číselník odvětví v tabulce mezd.

`czechia_payroll_unit` – Číselník jednotek hodnot v tabulce mezd.

`czechia_payroll_value_type` – Číselník typů hodnot v tabulce mezd.

`czechia_price` – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

`czechia_price_category` – Číselník kategorií potravin, které se vyskytují v našem přehledu.

## **Číselníky sdílených informací o ČR:**

`czechia_region` – Číselník krajů České republiky dle normy CZ-NUTS 2.

`czechia_district` – Číselník okresů České republiky dle normy LAU.

## **Dodatečné tabulky:**

`countries` - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.

`economies` - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

## **Primární a sekundární tabulka**

### **Primární tabulka**
Nejdříve byla vytvořena tabulka `average_price`, kde je vypočítaný průměr cen jednotlivých kategorií potravin za každý jeden rok. Průměr cen potravin byl vypočítán kvůli tomu, aby pro každou kategorii potravin byla v každém jednom roce pouze jedna hodnota (v původní tabulce `czechia_price` je totiž pro každou kategorii potravin několik měření ceny během každého roku).

Následovalo vytvoření tabulky `average_wages`, kde je vypočítaný průměr mezd jednotlivých kategorií odvětví pro každý jeden rok. Průměr mezd byl vypočítán kvůli tomu, aby pro každou kategorii odvětví byla v každém jednom roce pouze jedna hodnota mzdy (v původní tabulce `czechia_payroll` je totiž pro každou kategorii odvětví mzda měřena kvartálně, tzn.každý jeden rok má 4 hodnoty mzdy pro každé ovětví).
Následně byly tabulky `average_price` a `average_wages` propojeny na základě roku, **primární tabulka je pojmenována `t_barbora_maskova_project_sql_primary_final`.**

### **Sekundární tabulka**
Sekundární tabulka byla vytvořena spojením tabulek `countries` a `economies`, atributem pro spojení tabulek byl sloupec country.  Tabulka countries byla připojena z toho důvodu, že díky tomu je možné jednoduše získat data pouze pro kontinent Evropa.
**Sekundární tabulka je pojmenována `t_barbora_maskova_project_SQL_secondary_final`.**


## **Výzkumné otázky**

### **1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

V rámci výzkumu proběhlo 228 měření mzdy v 19 odvětvích. Výzkum byl proveden mezi lety 2006 – 2018. Meziroční pokles mzdy byl zaznamenán u 25 výsledků, což představuje zhruba 11 % ze všech měření.

Od roku 2006 do roku 2008 mzdy rostou ve všech odvětvích. Poté přichází dopady celosvětové ekonomické krize nazývané Velká recese a u některých odvětví dochází k meziročním poklesům průměrné mzdy, nejvíce byl postižen rok 2013.

Dá se říct, že mezi roky 2014 - 2018 průměrné mzdy rostou kontinuálně s výjimkou vždy jednoho odvětví mezi roky 2014 – 2016.

V roce 2009 došlo k meziročnímu poklesu růstu mezd u 4 odvětví, největší pokles v tomto roce zaznamenalo odvětví Těžba a dobývání, kdy došlo k meziročnímu poklesu průměrné mzdy o 3,1 % z 29273 Kč v roce 2008 na 28361 Kč v roce 2009.

V roce 2010 došlo k meziročnímu poklesu růstu mezd u 3 odvětví, největší pokles v tomto roce zaznamenalo odvětví Vzdělávání, kdy došlo k meziročnímu poklesu průměrné mzdy o 1,7 % z 23416 Kč v roce 2009 na 23023 Kč v roce 2010.

V roce 2011 došlo k meziročnímu poklesu růstu mezd u 4 odvětví, největší pokles v tomto roce zaznamenalo odvětví Veřejná správa a obrana; povinné sociální zabezpečení, kdy došlo k meziročnímu poklesu průměrné mzdy o 2,3 % z 26944 Kč v roce 2010 na 26331 Kč v roce 2011.

V roce 2012 došlo k meziročnímu růstu mezd u všech odvětví.

**V roce 2013 došlo k meziročnímu poklesu růstu mezd u 11 odvětví, největší pokles v tomto roce zaznamenalo odvětví Peněžnictví a pojišťovnictví, , kdy došlo k meziročnímu poklesu průměrné mzdy o 8,8 % z 50801 Kč v roce 2012 na 46317 Kč v roce 2013.**

V roce 2014 došlo k meziročnímu poklesu růstu mzdy pouze u odvětví Těžba a dobývání, kdy došlo k meziročnímu poklesu průměrné mzdy o 0,6 % z 31487 Kč v roce 2013 na 31302 Kč v roce 2014.

V roce 2015 došlo k meziročnímu poklesu růstu mzdy pouze u odvětví Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu, kdy došlo k meziročnímu poklesu průměrné mzdy o 1,6 % z 41094 Kč v roce 2014 na 40453 Kč v roce 2015.

V roce 2016 došlo k meziročnímu poklesu růstu mzdy pouze u odvětví Těžba a dobývání, kdy došlo k meziročnímu poklesu průměrné mzdy o 0,6 % z 31809 Kč v roce 2015 na 31626 Kč v roce 2016.

V roce 2017 a 2018 došlo k meziročnímu růstu mezd u všech odvětví.


### **2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

Za první srovnatelné období (rok 2006) je možné nakoupit 1465 litrů mléka, při ceně 14,44 Kč za litr mléka a průměrné mzdě ve výši 21165 Kč.

Za poslední srovnatelné období (rok 2018) je možné nakoupit 1669 litrů mléka, což představuje možnost nákupu o 204 litrů mléka více než v roce 2006. Cena za litr mléka v roce 2018 činí 19,82 Kč a průměrná mzda je ve výši 33092 Kč.

Za první srovnatelné období (rok 2006) je možné nakoupit 1312 kg chleba, při ceně 16,12 Kč za kilogram chleba a průměrné mzdě ve výši 21165 Kč.

Za poslední srovnatelné období (rok 2018) je možné nakoupit 1365 kg chleba, což představuje možnost nákupu o 53 kg chleba více než v roce 2006. Cena za kilogram chleba v roce 2018 činí 24,24 Kč a průměrná mzda je ve výši 33092 Kč.


### **3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

V rámci výzkumu proběhlo 315 měření cen potravin. Do výzkumu bylo zařazeno 27 kategorií základních potravin. Výzkum byl proveden mezi lety 2006 – 2018. Meziroční pokles cen potravin byl zaznamenán u 119 výsledků, což představuje zhruba 38 % ze všech měření.

Ve sledovaném období došlo k největšímu meziročnímu zlevnění u položky Rajská jablka červená kulatá, kdy se v roce 2007 snížila cena o 30 % oproti roku předcházejícímu. 
V tomto roce došlo i k největšímu meziročnímu zdražení, a to u položky Papriky, kdy se cena zvýšila o 95 % oproti roku předcházejícímu. 

Za celé sledované období zdražuje nejpomaleji Cukr krystalový, kdy se cena dokonce snížila o 1,9 %. Rajská jablka červená kulatá zaznamenávají taktéž snížení ceny o 0,7 %. Banány žluté zdražují o 0,8 %.
Naopak nejrychleji zdražují Papriky a to o 7,3 %, Máslo o 6,7 % a Vejce slepičí čerstvá o 5,6 %.
 
### **4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

V rámci výzkumu proběhlo 12 měření porovnání růstu cen potravin a růstu mezd mezi lety 2006 – 2018. 
Největší rozdíl pří porovnání růstu cen potravin a růstu mezd byl zaznamenán v roce 2013, kdy se ceny potravin meziročně zvýšily o 5,2 % a růst mezd se meziročně snížil o 1,6 %. 

V roce 2010 došlo ke stejnému meziročnímu růstu cen potravin i růstu mezd, ceny potravin a mzdy se v roce 2010 meziročně zvýšily o 1,9 %.
   
### **5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**

V rámci výzkumu proběhlo 12 měření porovnání růstu HDP s růstem cen potravin a s růstem mezd mezi lety 2006 – 2018. Na základě sledovaných dat nelze potvrdit přímou závislost vlivu HDP na růst mezd nebo cen potravin. Ceny potravin zaznamenaly během sledovaného období tři meziroční poklesy, mzdy za sledované období klesly pouze jednou, HDP zaznamenalo tři meziroční poklesy.

*`Poznámka:`
Problematika okolo růstu HDP je složitější a zapojuje se do ní více faktorů jako růst soukromé spotřeby, zvýšení investiční aktivity podnikové sféry, růst vládních výdajů, růst exportu.
Tempo růstu nominálních mezd by v dlouhodobém průměru mělo být úměrné nominálnímu tempu růstu HDP. Nominální růst mezd je vždy nutné vnímat v kontextu dalších ekonomických parametrů, jako je inflace a rychlost růstu ekonomiky.*
