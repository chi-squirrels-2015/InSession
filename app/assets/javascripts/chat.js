/**
 * Chat logic
 *
 * Most of the js functionality is inspired from anatgarg.com
 * jQuery tag Module from the tutorial
 * http://anantgarg.com/2009/05/13/gmail-facebook-style-jquery-chat/
 *
 */


var chatboxFocus = new Array();
var chatBoxes = new Array();

var ready = function () {

    chatBox = {

        /**
         * creates an inline chatbox on the page by calling the
         * createChatBox function passing along the unique conversation_id
         *
         * @param conversation_id
         */

        chatWith: function (conversation_id) {

            chatBox.createChatBox(conversation_id);
            $("#chatbox_" + conversation_id + " .chatboxtextarea").focus();
        },

        /**
         * closes the chatbox by essentially hiding it from the page
         *
         * @param conversation_id
         */

        close: function (conversation_id) {
            $('#chatbox_' + conversation_id).css('display', 'none');
            chatBox.restructure();
        },

        /**
         * Plays a notification sound when a new chat message arrives
         */

        notify: function () {
            var audioplayer = $('#ChatNotificationMsg')[0];
            console.log('youhaveanewmsg')
            $( "#dialog" ).dialog();
        },

        /**
         * Handles 'smart layouts' of the chatboxes. Like when new chatboxes are
         * added or removed from the view, it restructures them so that they appear
         * neatly aligned on the page
         */

        restructure: function () {
            align = 0;
            for (x in chatBoxes) {
                chatbox_id = chatBoxes[x];

                if ($("#chatbox_" + chatbox_id).css('display') != 'none') {
                    if (align == 0) {
                        $("#chatbox_" + chatbox_id).css('right', '20px');
                    } else {
                        width = (align) * (280 + 7) + 20;
                        $("#chatbox_" + chatbox_id).css('right', width + 'px');
                    }
                    align++;
                }
            }

        },

        /**
         * Takes in two parameters. It is responsible for fetching the specific conversation's
         * html page and appending it to the body of our home page e.g if conversation_id = 1
         *
         * $.get("conversations/1, function(data){
         *    // rest of the logic here
         * }, "html")
         *
         * @param conversation_id
         * @param minimizeChatBox
         */

        createChatBox: function (conversation_id, minimizeChatBox) {
        },

        /**
         * Responsible for listening to the keypresses when chatting. If the Enter button is pressed,
         * we submit our conversation form to our rails app
         *
         * @param event
         * @param chatboxtextarea
         * @param conversation_id
         */

        checkInputKey: function (event, chatboxtextarea, conversation_id) {
        },

        /**
         * Responsible for handling minimize and maximize of the chatbox
         *
         * @param conversation_id
         */

        toggleChatBoxGrowth: function (conversation_id) {
        }



    }

}

$(document).ready(ready);
$(document).on("page:load", ready);
