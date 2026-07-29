Create View vOndate_Conthist as select accountno, max(ondate) as last_contact group by accountno

Select contact1.company, contact1.key5 as [Acct#],contsupp.address2 as Contact, contsupp.contsupref as email, contact1.key4 as [Emco Rep], 
case 
     when contact1.key4 like 'Martin Kappus%' then 'mkappus@emcoplastics.com'
     when contact1.key4 like 'Sean Lijoi%' then 'slijoi@emcoplastics.com'
     when contact1.key4 like 'Bert Serrano%' then 'aserrano@emcoplastics.com'
     when contact1.key4 like 'Robert Levin%' then 'rlevin@emcoplastics.com'
     when contact1.key4 like 'Chris Warner%' then 'cwarner@emcoplastics.com'
     when contact1.key4 like 'Mike Weaver%' then 'mweaver@emcoplastics.com'
     else ''
end as [Emco Rep], vOndate_Conthist.last_contact as [Last Contact],
contsupp.linkacct as ignore
 
from contact1,contsupp
 
where contact1.accountno = contsupp.accountno
and contact1.key1 <> 'Inactive Account'
and contsupp.contact ='E-mail Address'
and contact1.key5 >='0' and contact1.key5 <> 'N/A'
order by contact1.company
