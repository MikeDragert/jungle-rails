describe('jungleRails', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit("localhost:3000/")
  })

  it('navigate to a product page', () => {
    cy.get('.hero .title').contains("The Jungle")
    cy.get(".products article").contains("Scented Blade").click()

    // cy.get("article.product-detail").contains("Scented Blade").should('be.visible')
    let article =  cy.get("article.product-detail").contains("Scented Blade")
    article.get(".quantity").should("be.visible")
    article.get(".price").should("be.visible")
    article.get(".quantity").contains("18 in stock at ").should("be.visible")
    article.get(".quantity").contains("$24.99").should("be.visible")
  })



})
