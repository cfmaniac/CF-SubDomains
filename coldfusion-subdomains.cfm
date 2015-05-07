<cfset defaultPath = "./">
<cfset pageRequest = "index.cfm">
 
<!--- Handle stardard WWW request --->
<cfif ListLen(CGI.SERVER_NAME,".") EQ 3 AND ListFirst(CGI.SERVER_NAME,".") EQ "www" OR ListLen(CGI.SERVER_NAME,".") EQ 2>
	<cfinclude template="#defaultPath#/#pageRequest#">

<!--- Handle subdomain request --->
<cfelseif ListLen(CGI.SERVER_NAME,".") EQ 3 AND ListFirst(CGI.SERVER_NAME,".") NEQ "www">
	
	<cfquery name="getSub" datasource="#dsn#">
		SELECT path
		FROM tblSubdomains
		WHERE subdomain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ListFirst(CGI.SERVER_NAME,'.')#">
	</cfquery>
	
	<cfif getSub.recordCount EQ 1>
		<cfinclude template="#getSub.path#/#pageRequest#">
	<cfelse>
		<cfinclude template="#defaultPath#/#pageRequest#">
	</cfif>
	
</cfif>