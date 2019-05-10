class Person {
  say () {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        console.log(parseInt(1000 * Math.random()))
        resolve()
      }, 500)
    })
  }
}

class Counter {
  constructor () {
    this.persons = [...Array(5)].map(a => { return new Person() })
    this.index = 0
  }

  start () {
    this.persons[this.index].say().then(this.callback)
  }

  callback = () =>  {
    if (this.index < this.persons.length - 1) {
      this.index += 1
      this.persons[this.index].say().then(this.callback)
    }
  }
}

c = new Counter ()
c.start()
