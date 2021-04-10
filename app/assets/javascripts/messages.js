
// window.onload = function () {
//   $(document).on('turbolinks:load', function () {
//     $('#post_message').on('submit', function (e) {
//       e.preventDefault();
//       var message = $("#message_text").val();
//       console.log(message);
//     })
//   });
// };

// window.onload = function () {
//   $(document).on('turbolinks:load', function () {
//     function buildHTML(message) {
//       var content = message.content ? `${ message.content } ` : "";
//       var html = `< div class="message" data - id="${message.id}" >
//                   <div class="message_detail">
//                     <p class="message_detail_current-user-name">
//                       ${message.user_name}
//                     <p class="message_detail_date">
//                       ${message.date}
//                     </p>
//                   </div>
//                   <p class="message_body">
//                     <div>
//                     ${content}
//                     </div>
//                   </p>
//                 </div>`
//       return html;
//     }
//   });
//   $(document).on('turbolinks:load', function () {
//     $('#new_message').on('submit', function (e) {
//       e.preventDefault();
//       var message = new FormData(this);
//       var url = 'shops/:id/messages/post';
//       $.ajax({
//         url: url,
//         type: 'POST',
//         data: message,
//         dataType: 'json',
//         processData: false,
//         contentType: false
//       })
//         .done(function (data) {
//           var html = buildHTML(data);
//           $('.messages').append(html);
//           $('#message_content').val('');
//           scrollBottom();
//         })
//         .fail(function (data) {
//           alert('エラーが発生したためメッセージは送信できませんでした');
//         })
//         .always(function (data) {
//           $('.submit-btn').prop('disabled', false);
//         })
//     })
//   });
// };

// function scrollBottom() {
//   var target = $('message').last();
//   var position = target.offset().top + $('.messages').scrollTop();
//   $('.messages').animate({
//     scrollTop: position
//   }, 300, 'swing');
// }