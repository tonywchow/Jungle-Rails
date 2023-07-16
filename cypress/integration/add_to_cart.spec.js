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

  it("should increase the cart count when 'Add' button is clicked", () => {
    // Find the first 'Add to Cart' button and click it
    cy.get(".products article")
      .first()
      .within(() => {
        cy.contains("Add").click({ force: true });
      });

    // Assert that the cart count has increased by one
    // cy.get(".cart-count").should("have.text", "1");
    cy.contains("My Cart (1)");
  });
});

// describe("Add to Cart", () => {
//   it("should increase the cart count when 'Add to Cart' button is clicked", () => {
//     // Visit the home page
//     cy.visit("/");

//     // Find the first 'Add to Cart' button and click it
//     cy.get(".products article").first().contains("Add to Cart").click();

//     // Assert that the cart count has increased by one
//     cy.get(".cart-count").should("have.text", "1");
//   });
// });
