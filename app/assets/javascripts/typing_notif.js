// TODO make es6 work in this file and export
// instead of globally declaring

class TypingNotif {
  constructor({ list, exclude }) {
    this.list = list;
    this.exclude = exclude instanceof Array 
      ? exclude 
      : [exclude];
  }

  get MAX_BEFORE_CROP() { return 3 }

  build() {
    if (!this.list) {
      return;
    }

    this.subtractExcluded();

    if (this.list.length === 0) {
      return;
    }

    const connector = this.list.length === 1
      ? 'is'
      : 'are';
    
    let users;
    if (this.list.length <= this.MAX_BEFORE_CROP) {
      users = this.toSentence(this.list);
    } else {
      total = this.list.length;
      users = this.toSentence([
        ...this.list.slice(0, MAX_BEFORE_CROP),
        `and ${total - MAX_BEFORE_CROP} others`
      ]);
    }

    return `${users} ${connector} typing...`;
  }

  get WORDS_CONNECTOR() { return ', ' }
  get TWO_WORDS_CONNECTOR() { return ' and ' }
  get LAST_WORD_CONNECTOR() { return ', and ' }

  toSentence(array) {
    switch(array.length) {
      case 1:
        return array[0];
      
      case 2:
        return `${array[0]}${this.TWO_WORDS_CONNECTOR}${array[1]}`;
    
      default:
        return `${array.slice(0, -1).join(this.WORDS_CONNECTOR)}${this.LAST_WORD_CONNECTOR}${array[array.length - 1]}`;
    }
  }

  subtractExcluded() {
    if (!this.exclude || this.exclude.length === 0) {
      return;
    }

    for(let i = 0; i < this.exclude.length; i++) {
      let idx = this.list.indexOf(this.exclude[i]);
      if (idx === -1) {
        continue;
      }

      this.list.splice(idx, 1);
    }
  }
}