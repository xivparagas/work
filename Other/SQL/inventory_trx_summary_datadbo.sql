SELECT doc_ord_no as [doc_ord_no],
       cus_no as [cus_no], cus_name as [cus_name],
       ap_vend_no as [ap_vend_no], vend_name as [vend_name],
       trx_dt as [trx_dt],
       item_no as [item_no], item_desc_1 as [item_desc_1], item_desc_2 as [item_desc_2],
       itrx_new_unit_cost as [itrx_new_unit_cost],
       old_qty as [old_qty], new_qty as [new_qty],
       SUM(trx_qty) as [trx_qty], SUM(ext_cost) as [ext_cost],
       im_trx_type as [im_trx_type], invtrx_comment as [invtrx_comment]
FROM (
    SELECT
        [oeordhdr_sql].cus_no as [cus_no],
        [arcusfil_sql].cus_name as [cus_name],
        [iminvtrx_sql].item_no as [item_no],
        cast(case ISDATE(rtrim([iminvtrx_sql].trx_dt)) when 1 then rtrim([iminvtrx_sql].trx_dt) else NULL end as date) as [trx_dt],
        iminvtrx_sql.quantity as [trx_qty],
        [iminvtrx_sql].old_quantity as [old_qty],
        iminvtrx_sql.old_quantity + isnull(case iminvtrx_sql.doc_type
            when 'T' then case when iminvtrx_sql.lev_no = 0 then -iminvtrx_sql.quantity else iminvtrx_sql.quantity end
            when 'I' then -iminvtrx_sql.quantity
            when 'R' then iminvtrx_sql.quantity
            when 'Z' then iminvtrx_sql.quantity
            when 'Q' then iminvtrx_sql.quantity
        end, 0) as [new_qty],
        [iminvtrx_sql].source as [source],
        [iminvtrx_sql].doc_type as [im_doc_type],
        case iminvtrx_sql.source when 'I' then 'I/M' when 'O' then 'O/E' when 'S' then 'SFC' when 'R' then 'P/O' when 'B' then 'I/M' when 'P' then 'POP' when 'C' then 'PhyInv' end as [im_pkg],
        case
            when iminvtrx_sql.doc_type = 'R' and iminvtrx_sql.source = 'P' then 'Disassembly'
            when iminvtrx_sql.doc_type = 'R' and iminvtrx_sql.source <> 'P' then 'Receipt'
            when iminvtrx_sql.doc_type = 'I' and iminvtrx_sql.source in ('P', 'S') then 'Backflush'
            when iminvtrx_sql.doc_type = 'I' and iminvtrx_sql.source = 'I' then 'Issue'
            when iminvtrx_sql.doc_type = 'I' and iminvtrx_sql.source = 'O' then 'Sale'
            when iminvtrx_sql.doc_type = 'T' and iminvtrx_sql.lev_no = 0 then 'Transfer Out'
            when iminvtrx_sql.doc_type = 'T' and iminvtrx_sql.lev_no = 1 then 'Transfer In'
            when iminvtrx_sql.doc_type = 'Q' then 'Qty Adj.'
            when doc_type = 'A' then 'Allocation'
            when iminvtrx_sql.doc_type = 'H' then 'Beg Bal'
            when iminvtrx_sql.doc_type = 'O' then 'On Order'
            when iminvtrx_sql.doc_type = 'B' then 'Bin Adj.'
            when iminvtrx_sql.doc_type = 'Z' and iminvtrx_sql.quantity > 0 then 'Production'
            when iminvtrx_sql.doc_type = 'Z' and iminvtrx_sql.quantity < 0 then 'Disassembly'
            when iminvtrx_sql.doc_type = 'C' then 'Cost Adj.'
            when iminvtrx_sql.doc_type = 'P' then 'Phy Count'
            else iminvtrx_sql.doc_type
        end as [im_trx_type],
        case iminvtrx_sql.doc_type
            when 'T' then case when iminvtrx_sql.lev_no = 0
                    then -iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
                    else  iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end end
            when 'I' then -iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
            when 'R' then  iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
            when 'Z' then  iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
            when 'Q' then  iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
            when 'C' then  iminvtrx_sql.quantity * case when iminvtrx_sql.doc_type in ('C') then iminvtrx_sql.new_unit_cost - iminvtrx_sql.unit_cost else iminvtrx_sql.unit_cost end
        end as [ext_cost],
        [iminvtrx_sql].comment as [invtrx_comment],
        [iminvtrx_sql].doc_ord_no as [doc_ord_no],
        [iminvtrx_sql].doc_source as [doc_source],
        [iminvtrx_sql].a4glidentity as [itrx_id],
        [iminvtrx_sql].new_unit_cost as [itrx_new_unit_cost],
        [iminvtrx_sql].id_no as [inv_trx_id_no],
        [LEAHYCONSULTING.#OPT_InventoryStatus].activity_cd as [activity_cd],
        [LEAHYCONSULTING.#OPT_InventoryStatus].item_desc_1 as [item_desc_1],
        [LEAHYCONSULTING.#OPT_InventoryStatus].item_loc as [item_loc],
        [LEAHYCONSULTING.#OPT_InventoryStatus].item_desc_2 as [item_desc_2],
        [poordhdr_sql].vend_no as [ap_vend_no],
        [apvenfil_sql].vend_name as [vend_name]
    FROM [DATA].[dbo].[iminvtrx_sql] as [iminvtrx_sql] WITH (NOLOCK)
    left join [DATA].[LEAHYCONSULTING].[OPT_InventoryStatus] as [LEAHYCONSULTING.#OPT_InventoryStatus] WITH (NOLOCK)
        on iminvtrx_sql.item_no = [LEAHYCONSULTING.#OPT_InventoryStatus].item_no
       and iminvtrx_sql.loc = [LEAHYCONSULTING.#OPT_InventoryStatus].item_loc
    left join [DATA].[dbo].[poordhdr_sql] as [poordhdr_sql] WITH (NOLOCK)
        on iminvtrx_sql.doc_ord_no = [poordhdr_sql].ord_no
       and iminvtrx_sql.source = 'R'
    left join [DATA].[dbo].[apvenfil_sql] as [apvenfil_sql] WITH (NOLOCK)
        on [apvenfil_sql].vend_no = [poordhdr_sql].vend_no
    left join [DATA].[dbo].[oeordhdr_sql] as [oeordhdr_sql] WITH (NOLOCK)
        on iminvtrx_sql.doc_ord_no = [oeordhdr_sql].ord_no
       and iminvtrx_sql.source = 'O'
    left join [DATA].[dbo].[arcusfil_sql] as [arcusfil_sql] WITH (NOLOCK)
        on [arcusfil_sql].cus_no = [oeordhdr_sql].cus_no
    WHERE (1=1)
      and iminvtrx_sql.source in ('I', 'O', 'S', 'R', 'B', 'P', 'C')
      and iminvtrx_sql.doc_type in ('B', 'H', 'I', 'P', 'Q', 'R', 'T', 'Z', 'O', 'C', 'A')
) as opt
GROUP BY doc_ord_no, cus_no, cus_name, ap_vend_no, vend_name,
         item_no, item_desc_1, item_desc_2, trx_dt,
         old_qty, new_qty, itrx_new_unit_cost, im_trx_type, invtrx_comment