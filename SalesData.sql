--Average purchase list price and sale price by state
SELECT a.state,
       AVG(p.listprice) AS AverageListPrice,
       AVG(p.saleprice) AS AverageSalePrice
    FROM purchase p 
    INNER JOIN customer c
    ON p.customerid = c.customerid
        INNER JOIN address a 
        ON c.addressid = a.addressid
    GROUP BY a.state;
    
    
--Average purchase list price and sale price by store
SELECT s.storename,
       AVG(p.listprice) AS AverageListPrice,
       AVG(p.saleprice) AS AverageSalePrice
    FROM purchase p
    INNER JOIN store s
    ON p.storeid = s.storeid
    GROUP BY s.storename;


--Compare averages by state to averages by store
SELECT a.state, s.storename,
       AVG(p.listprice) AS AverageListPrice,
       AVG(p.saleprice) AS AverageSalePrice
    FROM purchase p 
    INNER JOIN customer c
    ON p.customerid = c.customerid
    INNER JOIN address a
    ON c.addressid = a.addressid
    INNER JOIN store s
    ON p.storeid = s.storeid
    GROUP BY a.state, s.storename
    ORDER BY a.state;


--Most popular paint color to least
SELECT pa.colorname, 
       COUNT(p.purchaseid) AS NumberPurchased
    FROM purchase p
    INNER JOIN bicycle b
    ON p.bicycleserialnumber = b.serialnumber
    INNER JOIN paint pa
    ON b.paintid = pa.paintid
    GROUP BY pa.colorname
    ORDER BY COUNT(p.purchaseid) DESC;
    


--Part manufacturers that are most popular by store
SELECT s.storename, pa.manufacturername,
       COUNT(pa.manufacturername) AS TotalPurchased
    FROM component c
        INNER JOIN part pa
        ON c.partid = pa.partid
        INNER JOIN bicycle b
        ON c.bicycleserialnumber = b.serialnumber
        INNER JOIN purchase p
        ON b.serialnumber = p.bicycleserialnumber
        INNER JOIN store s
        ON p.storeid = s.storeid
    GROUP BY s.storename, pa.manufacturername
    ORDER BY COUNT(pa.manufacturername) DESC;
