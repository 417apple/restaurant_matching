<template>
  <div>
    <form action="/contacts" method="POST">
      <input type="hidden" name="authenticity_token" v-model="csrfToken">
      <p>{{ message }}</p>
      <p>内容: {{ newContact }}</p>
      <p>入力: <input type="text" name="contents" v-model="newContact"></p>
      <button type="submit">送信</button>
    </form>
  </div>
</template>

<script>
const STORAGE_KEY = 'contacts-vuejs-demo'
var contactStorage = {
  save: function (contacts) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(contacts)) //JSON.parseの逆。JSON.stringify( オブジェクトデータ )とすることでオブジェクトデータをjsonデータ化することができる。jsonデータでストレージに保存する。
  }
}
export default {
  name: 'hello',
  data: function () {
    return {
      message: "お問い合わせフォーム",
      contacts : [],
      newContact: "",
      csrfToken: document.getElementsByName("csrf-token")[0].content

    }
  },
  watch: {
    contacts: {
      handler: function (contacts) {
        contactStorage.save(contacts)
      },
      deep: true  //配列の中身が変わった場合にも監視イベントを発生させる場合はtrue
    }
  },
  // created: {
  //   this.csrfToken = document.getElementsByName("csrf-token")[0].content;
  // },
  methods: {
    // createContact: function(event) {
    //   event.preventDefault();
    //   let text = this.newContact && this.newContact.trim(); //trim 削除したい対象文字列の前後の空白を削除する機能
    //   if (!text) {
    //     return
    //   }
    //   this.contacts.push({
    //     text: text,
    //     done: false,
    //     editing: false
    //   })
    //   this.newContact = ''
    // }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
