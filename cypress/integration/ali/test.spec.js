describe('Navigation', function () {

  it('Go to a blog, about page and back home', function () {

    cy.viewport(1637, 877)

    cy.visit('/')

    cy.get('body > .container > .content > .page > h1').click()

    cy.get('.container > .nav > .list > .item-2 > a').click()

    cy.visit('/blog/')

    cy.get('.list > .item:nth-child(1) > .article > h2 > a').click()

    cy.visit('/blog/creer-rapidement-une-landing-page-avec-tailwind-css/')

    cy.get('.footer > .container > .copyright > .small > a:nth-child(3)').click()

    cy.visit('/a-propos/')

    cy.get('body > .header > .container > .logo > img').click()

    cy.visit('/')

  })

})