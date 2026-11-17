select 
  vb.vbeln as salesdocument, 
  vb.auart as salesdocumenttype,
  VP.WERKS as plant,
  vp.posnr as lineitem, 
  vp.matnr as materialnumber,
  vp.arktx as materialdescription,
  case when vb.erdat <> '00000000' then to_date(vb.erdat,'yyyymmdd') else null end as recordcreationdate, 
  vb.ernam as usercreated, 
  case when vb.audat <> '00000000' then to_date(vb.audat,'yyyymmdd') else null end as documentdate, 
  vp.mwsbp as SD_taxamount,
  vb.kunnr as soldtocustomer,
  kn.land1 as country,
  kn.name1 as soldtocustomername,
  case when vk.gbstk <> 'C' then 'Open' else 'Closed' end as status
from 
  slt_ods.vbak vb 
  inner join slt_ods.vbuk vk on vk.vbeln = vb.vbeln 
  and vk.gbstk <> 'C' 
  inner join slt_ods.vbap vp on vp.vbeln = vb.vbeln 
  and vp.abgru = ' ' and vp.mwsbp = '0'
  left join slt_ods.kna1 kn on kn.kunnr = vb.kunnr
where 
  vb.vkorg = '4450' and vb.auart = 'ZOR'
