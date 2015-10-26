
newparam(:unless) do

  desc <<-EOD
  A query to determine if the ora_exec must execute or not.

  If the query returns something, either one or more rows, the ora_exec
  is **NOT** executed. If the query returns no rows, the specified ora_exec
  statement **IS** executed.

  The unless clause **must** be a valid query. An error in the query will result in
  a failure of the apply statement.

  If you have specified a username and a password, the unless statement will be
  executed in that context. E.g. logged in as the specfied user with the specfied
  password.
  EOD


end
