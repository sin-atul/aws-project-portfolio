CREATE TABLE part
(
    p_partkey INTEGER NOT NULL,
    p_name VARCHAR(22) NOT NULL,
    p_mfgr VARCHAR(6),
    p_category VARCHAR(7) NOT NULL,
    p_brand1 VARCHAR(9) NOT NULL,
    p_color VARCHAR(11) NOT NULL,
    p_type VARCHAR(25) NOT NULL,
    p_size INTEGER NOT NULL,
    p_container VARCHAR(10) NOT NULL 
);


CREATE TABLE customer
(
    c_custtkey INTEGER NOT NULL,
    c_name VARCHAR(25) NOT NULL,
    c_address VARCHAR(25) NOT NULL,
    c_city VARCHAR(10) NOT NULL,
    c_nation VARCHAR(15) NOT NULL,
    c_region VARCHAR(12) NOT NULL,
    c_phone VARCHAR(15) NOT NULL,
    c_mktsegment VARCHAR(10) NOT NULL 
);




select * from part


copy part from 's3://redshift-bucket--input/LoadingDataSampleFiles/part-csv.tbl'
credentials 'aws_iam_role=arn:aws:iam::208491459696:role/Amazonredshift-commandaccess'
csv
null as '\000';


copy customer from 's3://redshift-bucket--input/LoadingDataSampleFiles/customer-fw-manifest'
credentials 'aws_iam_role=arn:aws:iam::208491459696:role/Amazonredshift-commandaccess'
fixedwidth 'c_custkey:10, c_name:25, c_address:25, c_city:10, c_nation:15, c_region:12, c_phone:15, c_mktsegment:10'
maxerror 10
acceptinvchars as '^'
manifest;


select * from customer



unload ('select * from venue')
to 's3://redshift-bucket--output/tickit/unload/venue_'
iam_role 'arn:aws:iam::208491459696:role/Amazonredshift-commandaccess'

unload ('select * from venue')
to 's3://redshift-bucket--output/tickit/unload/venue_'
iam_role 'arn:aws:iam::208491459696:role/Amazonredshift-commandaccess'
parallel off;