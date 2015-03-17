# Demo of AR joins and scoped_search

<pre>
$ rake test
Run options: --seed 4085

# Running:

.E

Finished in 0.053418s, 37.4404 runs/s, 18.7202 assertions/s.

  1) Error:
ReportTest#test_my_reports_with_scoped_search:
ActiveRecord::StatementInvalid: SQLite3::SQLException: no such column: hostgroups.name: SELECT "reports"."id" FROM "reports" WHERE "reports"."host_id" IN (SELECT "hosts"."id" FROM "hosts" WHERE (("hostgroups"."name" = 'One')))
    test/models/report_test.rb:5:in `block in <class:ReportTest>'

2 runs, 1 assertions, 0 failures, 1 errors, 0 skips
</pre>

Logs:

<pre>
  ActiveRecord::SchemaMigration Load (0.1ms)  SELECT "schema_migrations".* FROM "schema_migrations"
   (0.1ms)  begin transaction
  Fixture Delete (0.2ms)  DELETE FROM "hostgroups"
  Fixture Insert (0.1ms)  INSERT INTO "hostgroups" ("name", "created_at", "updated_at", "id") VALUES ('One', '2015-03-17 15:09:08', '2015-03-17 15:09:08', 980190962)
  Fixture Delete (0.0ms)  DELETE FROM "reports"
  Fixture Insert (0.0ms)  INSERT INTO "reports" ("created_at", "updated_at", "id", "host_id") VALUES ('2015-03-17 15:09:08', '2015-03-17 15:09:08', 980190962, 980190962)
  Fixture Insert (0.0ms)  INSERT INTO "reports" ("created_at", "updated_at", "id", "host_id") VALUES ('2015-03-17 15:09:08', '2015-03-17 15:09:08', 298486374, 980190962)
  Fixture Delete (0.0ms)  DELETE FROM "hosts"
  Fixture Insert (0.0ms)  INSERT INTO "hosts" ("name", "created_at", "updated_at", "id", "hostgroup_id") VALUES ('foo.example.com', '2015-03-17 15:09:08', '2015-03-17 15:09:08', 980190962, 980190962)
   (27.5ms)  commit transaction
   (0.1ms)  begin transaction
----------------------------------------
ReportTest: test_my_reports_via_plain_AR
----------------------------------------
   (0.1ms)  SELECT "reports"."id" FROM "reports"
   (0.2ms)  SELECT "reports"."id" FROM "reports" INNER JOIN "hosts" ON "hosts"."id" = "reports"."host_id" INNER JOIN "hostgroups" ON "hostgroups"."id" = "hosts"."hostgroup_id" WHERE (hostgroups.name = "One")
   (0.0ms)  rollback transaction
   (0.0ms)  begin transaction
----------------------------------------------
ReportTest: test_my_reports_with_scoped_search
----------------------------------------------
   (0.1ms)  SELECT "reports"."id" FROM "reports"
   (0.3ms)  SELECT "reports"."id" FROM "reports" WHERE "reports"."host_id" IN (SELECT "hosts"."id" FROM "hosts" WHERE (("hostgroups"."name" = 'One')))
SQLite3::SQLException: no such column: hostgroups.name: SELECT "reports"."id" FROM "reports" WHERE "reports"."host_id" IN (SELECT "hosts"."id" FROM "hosts" WHERE (("hostgroups"."name" = 'One')))
   (0.1ms)  rollback transaction
</pre>
