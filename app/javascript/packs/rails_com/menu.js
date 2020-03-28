import { Controller } from 'stimulus'

// data-controller="menu"
class MenuController extends Controller {

  connect() {
    console.log('Menu Controller works!')
    if (this.element.lastElementChild.children.length === 0) {
      this.element.style.display = 'none'
    }
  }

  toggle() {
    this.element.classList.toggle('is-active')
  }

}

application.register('menu', MenuController)