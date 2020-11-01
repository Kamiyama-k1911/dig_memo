// $(document).on('turbolinks:load', function(){
//   $('#demo-plus').on('click', function() {
//     alert("テスト成功!");
//   });
// });

$(document).on('turbolinks:load', function(){
  var list = $(".item-form__list").length;
  var i = list + 1;
  $('#item-form__plus').on('click', function() {
    const HTML = `<div class="form-group mb">
    <li class="item-form__list" style="width: 100%">
      <label class="mt-3" for="article_question">問い`+ i +`</label>
      <select name="items[item`+i+`][]" class="form-control custom-select" id="article_question"><option value="">選択して下さい</option>
      <option value="why">なぜ？</option>
      <option value="how">どうやって？</option>
      <option value="who">誰？</option>
      <option value="where">どこで？</option>
      <option value="what">何？</option>
      <option value="summary">一言で言うと？</option>
      <option value="application">どうやって応用する？</option>
      <option value="other">その他</option></select>

      <label for="article_body">内容`+ i +`</label>
      <textarea name="items[item`+i+`][]" autofocus="autofocus" autocomplete="body" class="form-control" id="article_body"></textarea>
    </li>
  </div>`
    $("#item-form").append(HTML);
     i++;
  });

  $("#item-form__minus").on("click", function(){
    var result = window.confirm(`最後の問いと内容が削除されます。よろしいですか？`)
    if( result ) {
      $(".item-form__list:last").empty().remove();
    }
    i = i - 1;
  })

});