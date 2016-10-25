// TODO import export
const HomeNamespace = {
  createTweetContainer(imageSource) {
    let tweet = createTweet(imageSource);

    let tweetContainer = document.createElement('div');
        tweetContainer.className = 'tweet-container';

    return tweetContainer;
  },

  // Tweet
  createTweet(image_source) {
    let tweetBody = createTweetBody(image_source);
    let tweetFooter = createTweetFooter();

    let tweet = document.createElement('div');
        tweet.className = 'tweet';
        tweet.appendChild(tweetBody);
        tweet.appendChild(tweetFooter);

    return tweet;
  },

  // TweetBody
  createTweetImage(imageSource) {
    let tweetImage = document.createElement('img');
        tweetImage.className = 'tweet-image';
        tweetImage.src = imageSource;

    return tweetImage;
  },

  createTweetBody(imageSource) {
    let tweetImage = createTweetImage(imageSource);

    let tweetBody = document.createElement('div');
        tweetBody.className = 'tweet-body';
        tweetBody.appendChild(tweetImage);

    return tweetBody;
  },

  // TwwetFooter
  createTweetFooter() {
    // TODO createdAt and userName

    let tweetFooter = document.createElement('div');
        tweetFooter.className = 'tweet-footer'
        // TODO append childs

    return tweetFooter;
  },

  // TODO Unobtrusive JavaScript
  onClick() {

  }
}
