describe('Navigation', function () {
  it('[Desktop] Blog post, about, home', function () {
    cy.viewport(1024, 768)
    cy.visit('/')
    cy.get('.container > .nav > .list > .item--nav-2 > a').click()
    cy.visit('/blog/')
    cy.get('.list > .item:nth-child(1) > .article > h2 > a').click()
    cy.get('.footer > .container > .copyright > .small > a:nth-child(3)').click()
    cy.get('body > .header > .container > .logo > img').click()
  })
})
