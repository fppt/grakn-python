Feature: Match Queries
    The user should be able to execute graql match queries which find concepts based on the contents of the query. These concepts should be returned to the user.

    Scenario: Match Non Existant Concept
    	Given A random graph with data
		When The user issues a match query
		And No concept matches
    	Then Return an empty response

    Scenario: Match Existant Concept
    	Given A random graph with data
		When The user issues a match query
		And Concepts match
    	Then Return a response with matching concepts