SELECT accountno, contsupref+address1 
FROM contsupp WHERE contact = 'Email Address' AND LIKE 'a%'

select c1.* from contact1 c1, contact2 c2 where c1.accountno = c2.accountno and 
c1.key1 = 'Customer' and
c1.U_KEY4 = 'HOUSE' 
AND c1.company LIKE '[a-c]%'
AND  c1.accountno not in
(select accountno from conthist where 
ondate >= '01/13/2024')

