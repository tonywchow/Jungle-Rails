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

  it("should navigate to product detail page", () => {
    // Find the first product on the page and click on it
    cy.get(".products article").first().click();

    // Assert that we are on the product detail page
    cy.contains("Product Details");
    // Add more assertions here to verify the content on the product detail page
  });
});
