describe('jungleRails', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit("localhost:3000/")
  })

  it('add to cart', () => {
    cy.get('.hero .title').contains("The Jungle")
    let article = cy.get(".products article").contains("Scented Blade")
    
    article.get('button').contains("Add").click({force:true})

    cy.get("#navbarSupportedContent .nav-link").contains(" My Cart (1)").should("be.visible")
    cy.get("#navbarSupportedContent .nav-link").get("i").should("have.class","fa-shopping-cart")

  })

})
