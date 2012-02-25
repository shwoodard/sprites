Feature: Creating sprites and stylesheets
  In order to avoid unnecessary image downloads
  As a developer
  I want to be able to generate image sprites

  Scenario: Create some sprites
    Given a project folder
    And it contains a sprites dsl definition file
    And it contains sprite images
    When I run the executable "sprites" with flags "-r spec/fixtures/project1"
    Then I should get valid sprites
