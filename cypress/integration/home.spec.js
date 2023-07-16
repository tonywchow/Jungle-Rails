describe("Home Page", () => {
  it("should visit the home page", () => {
    // Visit the home page
    cy.visit("/");

    // Assert that the page contains the expected content
    cy.contains("The Jungle");
    cy.contains("Where you can find any plants!");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
