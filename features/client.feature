Feature: Client
    As a Grakn Developer I should be able to connect to a running Grakn Instance and use that instance to issue queries.

    Scenario: Issueing A Valid Query
    	Given A graph containing types and instances
		When The user issues a valid query
    	Then Return a response

    Scenario: Issueing An invalid Query
    	Given A graph containing types and instances
		When The user issues an invalid query
    	Then Return an error

    Scenario: Issueing a query with a broken connection
        Given A broken connection to the database
        When The user issues a query
        Then Return an error

    Scenario: Creating a connection to a graph
        Given A graph which exists
        When The user connects to the graph
        Then Return a usable connection

    Scenario: Creating a connection to a non-existant graph
        Given A graph which does not exist
        When The user connects to the graph
        Then Create a new graph