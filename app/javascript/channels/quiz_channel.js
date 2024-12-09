import consumer from "./consumer"

const activeSubscriptions = new Set();
let quizSubscription = null;

document.addEventListener('turbo:load', () => {
  const quizElement = document.getElementById('quiz')
  if (quizElement) {
    const quizId = quizElement.dataset.quizId

    if (!quizSubscription) {
      consumer.ensureActiveConnection()

      // Subscription: https://github.com/rails/rails/blob/main/actioncable/app/javascript/action_cable/subscription.js
      quizSubscription = consumer.subscriptions.create(
        { channel: "QuizChannel", id: quizId },
        {
          connected() {
            console.log(`Connected to QuizChannel ${quizId}`)
          },

          disconnected() {
            console.log(`Disconnected from QuizChannel ${quizId}`)
          },

          received(data) {
            this.addParticipant(data)
        },

        addParticipant(data) {
          const participantCountElement = document.getElementById('participants_count')
            participantCountElement.textContent = data.participation_count

            const participantListElement = document.getElementById('participations_list')
            const newParticipantElement = this.renderParticipant(data.participant)
            participantListElement.appendChild(newParticipantElement)
          },

        renderParticipant(participant) {
          const li = document.createElement('li')
          li.textContent = participant
          return li
        }
      })

      activeSubscriptions.add(quizSubscription)
    }
  } else {
    unsubscribeFromQuiz()
  }
})

// Unsubscribe from the quiz channel when the page is navigated away from
export const unsubscribeFromQuiz = () => {
  if (quizSubscription) {
    // Use built-in method `unsubscribe()` of Subscription
    // https://github.com/rails/rails/blob/main/actioncable/app/javascript/action_cable/subscription.js
    quizSubscription.unsubscribe();

    if (activeSubscriptions.delete(quizSubscription)) {
      console.log('Unsubscribed from QuizChannel')
      quizSubscription = null;
    }

    if (activeSubscriptions.size === 0) {
      console.log('Disconnecting from ActionCable')
      consumer.disconnect();
    }
  }
};

// Add event listener for page navigation
document.addEventListener('turbo:before-visit', () => {
  unsubscribeFromQuiz();
});
