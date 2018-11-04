# Start all services
# This is the same as the default script /usr/bin/docker-quickstart
# Except that it does not hang after starting services
DAEMONS="\
    mysqld \
    cloudera-quickstart-init"

if [ -e /var/lib/cloudera-quickstart/.kerberos ]; then
    DAEMONS="${DAEMONS} \
        krb5kdc \
        kadmin"
fi

if [ -e /var/lib/cloudera-quickstart/.cloudera-manager ]; then
    DAEMONS="${DAEMONS} \
        cloudera-scm-server-db \
        cloudera-scb-server \
        cloudera-scm-server-db"
else
    DAEMONS="${DAEMONS} \
        zookeeper-server \
        hadoop-hdfs-datanode \
        hadoop-hdfs-journalnode \
        hadoop-hdfs-namenode \
        hadoop-hdfs-secondarynamenode \
        hadoop-httpfs \
        hadoop-mapreduce-historyserver \
        hadoop-yarn-nodemanager \
        hadoop-yarn-resourcemanager \
        hbase-master \
        hbase-rest \
        hbase-thrift \
        hive-metastore \
        hive-server2 \
        sqoop2-server \
        spark-history-server \
        hbase-regionserver \
        hue \
        impala-state-store \
        oozie \
        solr-server \
        impala-catalog \
        impala-server"
fi

for daemon in ${DAEMONS}; do
    sudo service ${daemon} start
done


# Create database and tables in Hive
hive<<EOF
CREATE DATABASE star_wars;
USE star_wars;


CREATE TABLE planet(
    name STRING,
    rotation_period INT,
    orbital_period INT,
    diameter INT,
    climate STRING,
    gravity STRING,
    terrain STRING,
    surface_water STRING,
    population BIGINT,
    created_date TIMESTAMP,
    updated_date TIMESTAMP,
    url STRING,
    id INT
) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

CREATE TABLE people(
    name STRING,
    height INT,
    mass FLOAT,
    hair_color STRING,
    skin_color STRING,
    eye_color STRING,
    birth_year STRING,
    gender STRING,
    planet_id INT,
    created_date TIMESTAMP,
    updated_date TIMESTAMP,
    url STRING,
    id INT
) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


INSERT INTO planet VALUES
('Alderaan','24','364','12500','temperate','1 standard','grasslands mountains','40','2000000000','2014-12-10 11:35:48.479000','2014-12-20 20:58:18.420000','https://swapi.co/api/planets/2/',2),
('Yavin IV','24','4818','10200','temperate tropical','1 standard','jungle rainforests','8','1000','2014-12-10 11:37:19.144000','2014-12-20 20:58:18.421000','https://swapi.co/api/planets/3/',3),
('Hoth','23','549','7200','frozen','1.1 standard','tundra ice caves mountain ranges','100',null,'2014-12-10 11:39:13.934000','2014-12-20 20:58:18.423000','https://swapi.co/api/planets/4/',4),
('Dagobah','23','341','8900','murky','N/A','swamp jungles','8',null,'2014-12-10 11:42:22.590000','2014-12-20 20:58:18.425000','https://swapi.co/api/planets/5/',5),
('Bespin','12','5110','118000','temperate','1.5 (surface) 1 standard (Cloud City)','gas giant','0','6000000','2014-12-10 11:43:55.240000','2014-12-20 20:58:18.427000','https://swapi.co/api/planets/6/',6),
('Endor','18','402','4900','temperate','0.85 standard','forests mountains lakes','8','30000000','2014-12-10 11:50:29.349000','2014-12-20 20:58:18.429000','https://swapi.co/api/planets/7/',7),
('Naboo','26','312','12120','temperate','1 standard','grassy hills swamps forests mountains','12','4500000000','2014-12-10 11:52:31.066000','2014-12-20 20:58:18.430000','https://swapi.co/api/planets/8/',8),
('Coruscant','24','368','12240','temperate','1 standard','cityscape mountains',null,'1000000000000','2014-12-10 11:54:13.921000','2014-12-20 20:58:18.432000','https://swapi.co/api/planets/9/',9),
('Kamino','27','463','19720','temperate','1 standard','ocean','100','1000000000','2014-12-10 12:45:06.577000','2014-12-20 20:58:18.434000','https://swapi.co/api/planets/10/',10),
('Geonosis','30','256','11370','temperate arid','0.9 standard','rock desert mountain barren','5','100000000000','2014-12-10 12:47:22.350000','2014-12-20 20:58:18.437000','https://swapi.co/api/planets/11/',11),
('Utapau','27','351','12900','temperate arid windy','1 standard','scrublands savanna canyons sinkholes','0.9','95000000','2014-12-10 12:49:01.491000','2014-12-20 20:58:18.439000','https://swapi.co/api/planets/12/',12),
('Mustafar','36','412','4200','hot','1 standard','volcanoes lava rivers mountains caves','0','20000','2014-12-10 12:50:16.526000','2014-12-20 20:58:18.440000','https://swapi.co/api/planets/13/',13),
('Kashyyyk','26','381','12765','tropical','1 standard','jungle forests lakes rivers','60','45000000','2014-12-10 13:32:00.124000','2014-12-20 20:58:18.442000','https://swapi.co/api/planets/14/',14),
('Polis Massa','24','590','0','artificial temperate','0.56 standard','airless asteroid','0','1000000','2014-12-10 13:33:46.405000','2014-12-20 20:58:18.444000','https://swapi.co/api/planets/15/',15),
('Mygeeto','12','167','10088','frigid','1 standard','glaciers mountains ice canyons',null,'19000000','2014-12-10 13:43:39.139000','2014-12-20 20:58:18.446000','https://swapi.co/api/planets/16/',16),
('Felucia','34','231','9100','hot humid','0.75 standard','fungus forests',null,'8500000','2014-12-10 13:44:50.397000','2014-12-20 20:58:18.447000','https://swapi.co/api/planets/17/',17),
('Cato Neimoidia','25','278','0','temperate moist','1 standard','mountains fields forests rock arches',null,'10000000','2014-12-10 13:46:28.704000','2014-12-20 20:58:18.449000','https://swapi.co/api/planets/18/',18),
('Saleucami','26','392','14920','hot',null,'caves desert mountains volcanoes',null,'1400000000','2014-12-10 13:47:46.874000','2014-12-20 20:58:18.450000','https://swapi.co/api/planets/19/',19),
('Stewjon',null,null,'0','temperate','1 standard','grass',null,null,'2014-12-10 16:16:26.566000','2014-12-20 20:58:18.452000','https://swapi.co/api/planets/20/',20),
('Eriadu','24','360','13490','polluted','1 standard','cityscape',null,'22000000000','2014-12-10 16:26:54.384000','2014-12-20 20:58:18.454000','https://swapi.co/api/planets/21/',21),
('Corellia','25','329','11000','temperate','1 standard','plains urban hills forests','70','3000000000','2014-12-10 16:49:12.453000','2014-12-20 20:58:18.456000','https://swapi.co/api/planets/22/',22),
('Rodia','29','305','7549','hot','1 standard','jungles oceans urban swamps','60','1300000000','2014-12-10 17:03:28.110000','2014-12-20 20:58:18.458000','https://swapi.co/api/planets/23/',23),
('Nal Hutta','87','413','12150','temperate','1 standard','urban oceans swamps bogs',null,'7000000000','2014-12-10 17:11:29.452000','2014-12-20 20:58:18.460000','https://swapi.co/api/planets/24/',24),
('Dantooine','25','378','9830','temperate','1 standard','oceans savannas mountains grasslands',null,'1000','2014-12-10 17:23:29.896000','2014-12-20 20:58:18.461000','https://swapi.co/api/planets/25/',25),
('Bestine IV','26','680','6400','temperate',null,'rocky islands oceans','98','62000000','2014-12-12 11:16:55.078000','2014-12-20 20:58:18.463000','https://swapi.co/api/planets/26/',26),
('Ord Mantell','26','334','14050','temperate','1 standard','plains seas mesas','10','4000000000','2014-12-15 12:23:41.661000','2014-12-20 20:58:18.464000','https://swapi.co/api/planets/27/',27),
('Unknown','0','0','0',null,null,null,null,null,'2014-12-15 12:25:59.569000','2014-12-20 20:58:18.466000','https://swapi.co/api/planets/28/',28),
('Trandosha','25','371','0','arid','0.62 standard','mountains seas grasslands deserts',null,'42000000','2014-12-15 12:53:47.695000','2014-12-20 20:58:18.468000','https://swapi.co/api/planets/29/',29),
('Socorro','20','326','0','arid','1 standard','deserts mountains',null,'300000000','2014-12-15 12:56:31.121000','2014-12-20 20:58:18.469000','https://swapi.co/api/planets/30/',30),
('Mon Cala','21','398','11030','temperate','1','oceans reefs islands','100','27000000000','2014-12-18 11:07:01.792000','2014-12-20 20:58:18.471000','https://swapi.co/api/planets/31/',31),
('Chandrila','20','368','13500','temperate','1','plains forests','40','1200000000','2014-12-18 11:11:51.872000','2014-12-20 20:58:18.472000','https://swapi.co/api/planets/32/',32),
('Sullust','20','263','12780','superheated','1','mountains volcanoes rocky deserts','5','18500000000','2014-12-18 11:25:40.243000','2014-12-20 20:58:18.474000','https://swapi.co/api/planets/33/',33),
('Toydaria','21','184','7900','temperate','1','swamps lakes',null,'11000000','2014-12-19 17:47:54.403000','2014-12-20 20:58:18.476000','https://swapi.co/api/planets/34/',34),
('Malastare','26','201','18880','arid temperate tropical','1.56','swamps deserts jungles mountains',null,'2000000000','2014-12-19 17:52:13.106000','2014-12-20 20:58:18.478000','https://swapi.co/api/planets/35/',35),
('Dathomir','24','491','10480','temperate','0.9','forests deserts savannas',null,'5200','2014-12-19 18:00:40.142000','2014-12-20 20:58:18.480000','https://swapi.co/api/planets/36/',36),
('Ryloth','30','305','10600','temperate arid subartic','1','mountains valleys deserts tundra','5','1500000000','2014-12-20 09:46:25.740000','2014-12-20 20:58:18.481000','https://swapi.co/api/planets/37/',37),
('Aleen Minor',null,null,null,null,null,null,null,null,'2014-12-20 09:52:23.452000','2014-12-20 20:58:18.483000','https://swapi.co/api/planets/38/',38),
('Vulpter','22','391','14900','temperate artic','1','urban barren',null,'421000000','2014-12-20 09:56:58.874000','2014-12-20 20:58:18.485000','https://swapi.co/api/planets/39/',39),
('Troiken',null,null,null,null,null,'desert tundra rainforests mountains',null,null,'2014-12-20 10:01:37.395000','2014-12-20 20:58:18.487000','https://swapi.co/api/planets/40/',40),
('Tund','48','1770','12190',null,null,'barren ash',null,'0','2014-12-20 10:07:29.578000','2014-12-20 20:58:18.489000','https://swapi.co/api/planets/41/',41),
('Haruun Kal','25','383','10120','temperate','0.98','toxic cloudsea plateaus volcanoes',null,'705300','2014-12-20 10:12:28.980000','2014-12-20 20:58:18.491000','https://swapi.co/api/planets/42/',42),
('Cerea','27','386',null,'temperate','1','verdant','20','450000000','2014-12-20 10:14:48.178000','2014-12-20 20:58:18.493000','https://swapi.co/api/planets/43/',43),
('Glee Anselm','33','206','15600','tropical temperate','1','lakes islands swamps seas','80','500000000','2014-12-20 10:18:26.110000','2014-12-20 20:58:18.495000','https://swapi.co/api/planets/44/',44),
('Iridonia','29','413',null,null,null,'rocky canyons acid pools',null,null,'2014-12-20 10:26:05.788000','2014-12-20 20:58:18.497000','https://swapi.co/api/planets/45/',45),
('Tholoth',null,null,null,null,null,null,null,null,'2014-12-20 10:28:31.117000','2014-12-20 20:58:18.498000','https://swapi.co/api/planets/46/',46),
('Iktotch','22','481',null,'arid rocky windy','1','rocky',null,null,'2014-12-20 10:31:32.413000','2014-12-20 20:58:18.500000','https://swapi.co/api/planets/47/',47),
('Quermia',null,null,null,null,null,null,null,null,'2014-12-20 10:34:08.249000','2014-12-20 20:58:18.502000','https://swapi.co/api/planets/48/',48),
('Dorin','22','409','13400','temperate','1',null,null,null,'2014-12-20 10:48:36.141000','2014-12-20 20:58:18.504000','https://swapi.co/api/planets/49/',49),
('Champala','27','318',null,'temperate','1','oceans rainforests plateaus',null,'3500000000','2014-12-20 10:52:51.524000','2014-12-20 20:58:18.506000','https://swapi.co/api/planets/50/',50),
('Mirial',null,null,null,null,null,'deserts',null,null,'2014-12-20 16:44:46.318000','2014-12-20 20:58:18.508000','https://swapi.co/api/planets/51/',51),
('Serenno',null,null,null,null,null,'rainforests rivers mountains',null,null,'2014-12-20 16:52:13.357000','2014-12-20 20:58:18.510000','https://swapi.co/api/planets/52/',52),
('Concord Dawn',null,null,null,null,null,'jungles forests deserts',null,null,'2014-12-20 16:54:39.909000','2014-12-20 20:58:18.512000','https://swapi.co/api/planets/53/',53),
('Zolan',null,null,null,null,null,null,null,null,'2014-12-20 16:56:37.250000','2014-12-20 20:58:18.514000','https://swapi.co/api/planets/54/',54),
('Ojom',null,null,null,'frigid',null,'oceans glaciers','100','500000000','2014-12-20 17:27:41.286000','2014-12-20 20:58:18.516000','https://swapi.co/api/planets/55/',55),
('Skako','27','384',null,'temperate','1','urban vines',null,'500000000000','2014-12-20 17:50:47.864000','2014-12-20 20:58:18.517000','https://swapi.co/api/planets/56/',56),
('Muunilinst','28','412','13800','temperate','1','plains forests hills mountains','25','5000000000','2014-12-20 17:57:47.420000','2014-12-20 20:58:18.519000','https://swapi.co/api/planets/57/',57),
('Shili',null,null,null,'temperate','1','cities savannahs seas plains',null,null,'2014-12-20 18:43:14.049000','2014-12-20 20:58:18.521000','https://swapi.co/api/planets/58/',58),
('Kalee','23','378','13850','arid temperate tropical','1','rainforests cliffs canyons seas',null,'4000000000','2014-12-20 19:43:51.278000','2014-12-20 20:58:18.523000','https://swapi.co/api/planets/59/',59),
('Umbara',null,null,null,null,null,null,null,null,'2014-12-20 20:18:36.256000','2014-12-20 20:58:18.525000','https://swapi.co/api/planets/60/',60),
('Tatooine','23','304','10465','arid','1 standard','desert','1','200000','2014-12-09 13:50:49.641000','2014-12-21 20:48:04.175778','https://swapi.co/api/planets/1/',1),
('Jakku',null,null,null,null,null,'deserts',null,null,'2015-04-17 06:55:57.556495','2015-04-17 06:55:57.556551','https://swapi.co/api/planets/61/',61);


INSERT INTO people VALUES
('Luke Skywalker','172','77','blond','fair','blue','19BBY','male',1,'2014-12-09 13:50:51.644000','2014-12-20 21:17:56.891000','https://swapi.co/api/people/1/',1),
('C-3PO','167','75','n/a','gold','yellow','112BBY','n/a',1,'2014-12-10 15:10:51.357000','2014-12-20 21:17:50.309000','https://swapi.co/api/people/2/',2),
('R2-D2','96','32','n/a','white blue','red','33BBY','n/a',8,'2014-12-10 15:11:50.376000','2014-12-20 21:17:50.311000','https://swapi.co/api/people/3/',3),
('Darth Vader','202','136','none','white','yellow','41.9BBY','male',1,'2014-12-10 15:18:20.704000','2014-12-20 21:17:50.313000','https://swapi.co/api/people/4/',4),
('Leia Organa','150','49','brown','light','brown','19BBY','female',2,'2014-12-10 15:20:09.791000','2014-12-20 21:17:50.315000','https://swapi.co/api/people/5/',5),
('Owen Lars','178','120','brown grey','light','blue','52BBY','male',1,'2014-12-10 15:52:14.024000','2014-12-20 21:17:50.317000','https://swapi.co/api/people/6/',6),
('Beru Whitesun lars','165','75','brown','light','blue','47BBY','female',1,'2014-12-10 15:53:41.121000','2014-12-20 21:17:50.319000','https://swapi.co/api/people/7/',7),
('R5-D4','97','32','n/a','white red','red',null,'n/a',1,'2014-12-10 15:57:50.959000','2014-12-20 21:17:50.321000','https://swapi.co/api/people/8/',8),
('Biggs Darklighter','183','84','black','light','brown','24BBY','male',1,'2014-12-10 15:59:50.509000','2014-12-20 21:17:50.323000','https://swapi.co/api/people/9/',9),
('Obi-Wan Kenobi','182','77','auburn white','fair','blue-gray','57BBY','male',20,'2014-12-10 16:16:29.192000','2014-12-20 21:17:50.325000','https://swapi.co/api/people/10/',10),
('Anakin Skywalker','188','84','blond','fair','blue','41.9BBY','male',1,'2014-12-10 16:20:44.310000','2014-12-20 21:17:50.327000','https://swapi.co/api/people/11/',11),
('Wilhuff Tarkin','180',null,'auburn grey','fair','blue','64BBY','male',21,'2014-12-10 16:26:56.138000','2014-12-20 21:17:50.330000','https://swapi.co/api/people/12/',12),
('Chewbacca','228','112','brown',null,'blue','200BBY','male',14,'2014-12-10 16:42:45.066000','2014-12-20 21:17:50.332000','https://swapi.co/api/people/13/',13),
('Han Solo','180','80','brown','fair','brown','29BBY','male',22,'2014-12-10 16:49:14.582000','2014-12-20 21:17:50.334000','https://swapi.co/api/people/14/',14),
('Greedo','173','74','n/a','green','black','44BBY','male',23,'2014-12-10 17:03:30.334000','2014-12-20 21:17:50.336000','https://swapi.co/api/people/15/',15),
('Jabba Desilijic Tiure','175','1358','n/a','green-tan brown','orange','600BBY','hermaphrodite',24,'2014-12-10 17:11:31.638000','2014-12-20 21:17:50.338000','https://swapi.co/api/people/16/',16),
('Wedge Antilles','170','77','brown','fair','hazel','21BBY','male',22,'2014-12-12 11:08:06.469000','2014-12-20 21:17:50.341000','https://swapi.co/api/people/18/',18),
('Jek Tono Porkins','180','110','brown','fair','blue',null,'male',26,'2014-12-12 11:16:56.569000','2014-12-20 21:17:50.343000','https://swapi.co/api/people/19/',19),
('Yoda','66','17','white','green','brown','896BBY','male',28,'2014-12-15 12:26:01.042000','2014-12-20 21:17:50.345000','https://swapi.co/api/people/20/',20),
('Palpatine','170','75','grey','pale','yellow','82BBY','male',8,'2014-12-15 12:48:05.971000','2014-12-20 21:17:50.347000','https://swapi.co/api/people/21/',21),
('Boba Fett','183','78.2','black','fair','brown','31.5BBY','male',10,'2014-12-15 12:49:32.457000','2014-12-20 21:17:50.349000','https://swapi.co/api/people/22/',22),
('IG-88','200','140','none','metal','red','15BBY','none',28,'2014-12-15 12:51:10.076000','2014-12-20 21:17:50.351000','https://swapi.co/api/people/23/',23),
('Bossk','190','113','none','green','red','53BBY','male',29,'2014-12-15 12:53:49.297000','2014-12-20 21:17:50.355000','https://swapi.co/api/people/24/',24),
('Lando Calrissian','177','79','black','dark','brown','31BBY','male',30,'2014-12-15 12:56:32.683000','2014-12-20 21:17:50.357000','https://swapi.co/api/people/25/',25),
('Lobot','175','79','none','light','blue','37BBY','male',6,'2014-12-15 13:01:57.178000','2014-12-20 21:17:50.359000','https://swapi.co/api/people/26/',26),
('Ackbar','180','83','none','brown mottle','orange','41BBY','male',31,'2014-12-18 11:07:50.584000','2014-12-20 21:17:50.362000','https://swapi.co/api/people/27/',27),
('Mon Mothma','150',null,'auburn','fair','blue','48BBY','female',32,'2014-12-18 11:12:38.895000','2014-12-20 21:17:50.364000','https://swapi.co/api/people/28/',28),
('Arvel Crynyd',null,null,'brown','fair','brown',null,'male',28,'2014-12-18 11:16:33.020000','2014-12-20 21:17:50.367000','https://swapi.co/api/people/29/',29),
('Wicket Systri Warrick','88','20','brown','brown','brown','8BBY','male',7,'2014-12-18 11:21:58.954000','2014-12-20 21:17:50.369000','https://swapi.co/api/people/30/',30),
('Nien Nunb','160','68','none','grey','black',null,'male',33,'2014-12-18 11:26:18.541000','2014-12-20 21:17:50.371000','https://swapi.co/api/people/31/',31),
('Qui-Gon Jinn','193','89','brown','fair','blue','92BBY','male',28,'2014-12-19 16:54:53.618000','2014-12-20 21:17:50.375000','https://swapi.co/api/people/32/',32),
('Nute Gunray','191','90','none','mottled green','red',null,'male',18,'2014-12-19 17:05:57.357000','2014-12-20 21:17:50.377000','https://swapi.co/api/people/33/',33),
('Finis Valorum','170',null,'blond','fair','blue','91BBY','male',9,'2014-12-19 17:21:45.915000','2014-12-20 21:17:50.379000','https://swapi.co/api/people/34/',34),
('Jar Jar Binks','196','66','none','orange','orange','52BBY','male',8,'2014-12-19 17:29:32.489000','2014-12-20 21:17:50.383000','https://swapi.co/api/people/36/',36),
('Roos Tarpals','224','82','none','grey','orange',null,'male',8,'2014-12-19 17:32:56.741000','2014-12-20 21:17:50.385000','https://swapi.co/api/people/37/',37),
('Rugor Nass','206',null,'none','green','orange',null,'male',8,'2014-12-19 17:33:38.909000','2014-12-20 21:17:50.388000','https://swapi.co/api/people/38/',38),
('Ric Olié','183',null,'brown','fair','blue',null,'male',8,'2014-12-19 17:45:01.522000','2014-12-20 21:17:50.392000','https://swapi.co/api/people/39/',39),
('Watto','137',null,'black','blue grey','yellow',null,'male',34,'2014-12-19 17:48:54.647000','2014-12-20 21:17:50.395000','https://swapi.co/api/people/40/',40),
('Sebulba','112','40','none','grey red','orange',null,'male',35,'2014-12-19 17:53:02.586000','2014-12-20 21:17:50.397000','https://swapi.co/api/people/41/',41),
('Quarsh Panaka','183',null,'black','dark','brown','62BBY','male',8,'2014-12-19 17:55:43.348000','2014-12-20 21:17:50.399000','https://swapi.co/api/people/42/',42),
('Shmi Skywalker','163',null,'black','fair','brown','72BBY','female',1,'2014-12-19 17:57:41.191000','2014-12-20 21:17:50.401000','https://swapi.co/api/people/43/',43),
('Darth Maul','175','80','none','red','yellow','54BBY','male',36,'2014-12-19 18:00:41.929000','2014-12-20 21:17:50.403000','https://swapi.co/api/people/44/',44),
('Bib Fortuna','180',null,'none','pale','pink',null,'male',37,'2014-12-20 09:47:02.512000','2014-12-20 21:17:50.407000','https://swapi.co/api/people/45/',45),
('Ayla Secura','178','55','none','blue','hazel','48BBY','female',37,'2014-12-20 09:48:01.172000','2014-12-20 21:17:50.409000','https://swapi.co/api/people/46/',46),
('Dud Bolt','94','45','none','blue grey','yellow',null,'male',39,'2014-12-20 09:57:31.858000','2014-12-20 21:17:50.414000','https://swapi.co/api/people/48/',48),
('Gasgano','122',null,'none','white blue','black',null,'male',40,'2014-12-20 10:02:12.223000','2014-12-20 21:17:50.416000','https://swapi.co/api/people/49/',49),
('Ben Quadinaros','163','65','none','grey green yellow','orange',null,'male',41,'2014-12-20 10:08:33.777000','2014-12-20 21:17:50.417000','https://swapi.co/api/people/50/',50),
('Mace Windu','188','84','none','dark','brown','72BBY','male',42,'2014-12-20 10:12:30.846000','2014-12-20 21:17:50.420000','https://swapi.co/api/people/51/',51),
('Ki-Adi-Mundi','198','82','white','pale','yellow','92BBY','male',43,'2014-12-20 10:15:32.293000','2014-12-20 21:17:50.422000','https://swapi.co/api/people/52/',52),
('Kit Fisto','196','87','none','green','black',null,'male',44,'2014-12-20 10:18:57.202000','2014-12-20 21:17:50.424000','https://swapi.co/api/people/53/',53),
('Eeth Koth','171',null,'black','brown','brown',null,'male',45,'2014-12-20 10:26:47.902000','2014-12-20 21:17:50.427000','https://swapi.co/api/people/54/',54),
('Adi Gallia','184','50','none','dark','blue',null,'female',9,'2014-12-20 10:29:11.661000','2014-12-20 21:17:50.432000','https://swapi.co/api/people/55/',55),
('Saesee Tiin','188',null,'none','pale','orange',null,'male',47,'2014-12-20 10:32:11.669000','2014-12-20 21:17:50.434000','https://swapi.co/api/people/56/',56),
('Yarael Poof','264',null,'none','white','yellow',null,'male',48,'2014-12-20 10:34:48.725000','2014-12-20 21:17:50.437000','https://swapi.co/api/people/57/',57),
('Plo Koon','188','80','none','orange','black','22BBY','male',49,'2014-12-20 10:49:19.859000','2014-12-20 21:17:50.439000','https://swapi.co/api/people/58/',58),
('Mas Amedda','196',null,'none','blue','blue',null,'male',50,'2014-12-20 10:53:26.457000','2014-12-20 21:17:50.442000','https://swapi.co/api/people/59/',59),
('Gregar Typho','185','85','black','dark','brown',null,'male',8,'2014-12-20 11:10:10.381000','2014-12-20 21:17:50.445000','https://swapi.co/api/people/60/',60),
('Cordé','157',null,'brown','light','brown',null,'female',8,'2014-12-20 11:11:39.630000','2014-12-20 21:17:50.449000','https://swapi.co/api/people/61/',61),
('Cliegg Lars','183',null,'brown','fair','blue','82BBY','male',1,'2014-12-20 15:59:03.958000','2014-12-20 21:17:50.451000','https://swapi.co/api/people/62/',62),
('Poggle the Lesser','183','80','none','green','yellow',null,'male',11,'2014-12-20 16:40:43.977000','2014-12-20 21:17:50.453000','https://swapi.co/api/people/63/',63),
('Luminara Unduli','170','56.2','black','yellow','blue','58BBY','female',51,'2014-12-20 16:45:53.668000','2014-12-20 21:17:50.455000','https://swapi.co/api/people/64/',64),
('Barriss Offee','166','50','black','yellow','blue','40BBY','female',51,'2014-12-20 16:46:40.440000','2014-12-20 21:17:50.457000','https://swapi.co/api/people/65/',65),
('Dormé','165',null,'brown','light','brown',null,'female',8,'2014-12-20 16:49:14.640000','2014-12-20 21:17:50.460000','https://swapi.co/api/people/66/',66),
('Dooku','193','80','white','fair','brown','102BBY','male',52,'2014-12-20 16:52:14.726000','2014-12-20 21:17:50.462000','https://swapi.co/api/people/67/',67),
('Bail Prestor Organa','191',null,'black','tan','brown','67BBY','male',2,'2014-12-20 16:53:08.575000','2014-12-20 21:17:50.463000','https://swapi.co/api/people/68/',68),
('Jango Fett','183','79','black','tan','brown','66BBY','male',53,'2014-12-20 16:54:41.620000','2014-12-20 21:17:50.465000','https://swapi.co/api/people/69/',69),
('Zam Wesell','168','55','blonde','fair green yellow','yellow',null,'female',54,'2014-12-20 16:57:44.471000','2014-12-20 21:17:50.468000','https://swapi.co/api/people/70/',70),
('Dexter Jettster','198','102','none','brown','yellow',null,'male',55,'2014-12-20 17:28:27.248000','2014-12-20 21:17:50.470000','https://swapi.co/api/people/71/',71),
('Lama Su','229','88','none','grey','black',null,'male',10,'2014-12-20 17:30:50.416000','2014-12-20 21:17:50.473000','https://swapi.co/api/people/72/',72),
('Taun We','213',null,'none','grey','black',null,'female',10,'2014-12-20 17:31:21.195000','2014-12-20 21:17:50.474000','https://swapi.co/api/people/73/',73),
('Jocasta Nu','167',null,'white','fair','blue',null,'female',9,'2014-12-20 17:32:51.996000','2014-12-20 21:17:50.476000','https://swapi.co/api/people/74/',74),
('Ratts Tyerell','79','15','none','grey blue',null,null,'male',38,'2014-12-20 09:53:15.086000','2016-06-30 12:52:19.604868','https://swapi.co/api/people/47/',47),
('R4-P17','96',null,'none','silver red','red blue',null,'female',28,'2014-12-20 17:43:36.409000','2014-12-20 21:17:50.478000','https://swapi.co/api/people/75/',75),
('Wat Tambor','193','48','none','green grey',null,null,'male',56,'2014-12-20 17:53:52.607000','2014-12-20 21:17:50.481000','https://swapi.co/api/people/76/',76),
('San Hill','191',null,'none','grey','gold',null,'male',57,'2014-12-20 17:58:17.049000','2014-12-20 21:17:50.484000','https://swapi.co/api/people/77/',77),
('Shaak Ti','178','57','none','red blue white','black',null,'female',58,'2014-12-20 18:44:01.103000','2014-12-20 21:17:50.486000','https://swapi.co/api/people/78/',78),
('Grievous','216','159','none','brown white','green yellow',null,'male',59,'2014-12-20 19:43:53.348000','2014-12-20 21:17:50.488000','https://swapi.co/api/people/79/',79),
('Tarfful','234','136','brown','brown','blue',null,'male',14,'2014-12-20 19:46:34.209000','2014-12-20 21:17:50.491000','https://swapi.co/api/people/80/',80),
('Raymus Antilles','188','79','brown','light','brown',null,'male',2,'2014-12-20 19:49:35.583000','2014-12-20 21:17:50.493000','https://swapi.co/api/people/81/',81),
('Sly Moore','178','48','none','pale','white',null,'female',60,'2014-12-20 20:18:37.619000','2014-12-20 21:17:50.496000','https://swapi.co/api/people/82/',82),
('Tion Medon','206','80','none','grey','black',null,'male',12,'2014-12-20 20:35:04.260000','2014-12-20 21:17:50.498000','https://swapi.co/api/people/83/',83),
('Finn',null,null,'black','dark','dark',null,'male',28,'2015-04-17 06:52:40.793621','2015-04-17 06:52:40.793674','https://swapi.co/api/people/84/',84),
('Rey',null,null,'brown','light','hazel',null,'female',28,'2015-04-17 06:54:01.495077','2015-04-17 06:54:01.495128','https://swapi.co/api/people/85/',85),
('Poe Dameron',null,null,'brown','light','brown',null,'male',28,'2015-04-17 06:55:21.622786','2015-04-17 06:55:21.622835','https://swapi.co/api/people/86/',86),
('BB8',null,null,'none','none','black',null,'none',28,'2015-04-17 06:57:38.061346','2015-04-17 06:57:38.061453','https://swapi.co/api/people/87/',87),
('Captain Phasma',null,null,null,null,null,null,'female',28,'2015-10-13 10:35:39.229823','2015-10-13 10:35:39.229894','https://swapi.co/api/people/88/',88),
('Padmé Amidala','165','45','brown','light','brown','46BBY','female',8,'2014-12-19 17:28:26.926000','2016-04-20 17:06:31.502555','https://swapi.co/api/people/35/',35);
quit;
EOF

exec bash
