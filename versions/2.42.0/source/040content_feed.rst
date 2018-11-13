Displaying Feeds
================

**Summary**: Provides default UI for displaying feeds of content tiles from users,
channel or other content feeds retrieved from the KWS Social API.

Includes functionality for liking and sharing content items via the KWS API,
and to report content to moderators.

Includes support for displaying image and video content within content tiles.
Content tiles include author information, in the form of a username and user
avatar, and support the presence of a text comment as part of the content.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyFeedActivity">

      <tv.superawesome.pj.ui.feed.views.DetailFeedView
        android:id="@+id/home_feed"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **DetailFeedView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyFeedActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        home_feed.setSkin(DetailFeedViewSkin())
        home_feed.bindTo(context.application.store)
        home_feed.setUser("__channel_or_user_id__", FeedType.HOME)
        home_feed.fetchFeed()
      }

      override fun onDestroy() {
        home_feed.unbindFrom(context.application.store)
        super.onDestroy()
      }
    }

And that's it!

.. note::
    Notice we have used Kotlin's **Kapt** extension in order to have direct access to the view via its ID. Good alternatives are Jake Wharton's `ButterKnife <http://jakewharton.github.io/butterknife/>`_ library or calling **findViewById** directly.

.. note::
    Notice the second parameter of the **setUser** method. This allows us to load different type of feeds like **.HOME**, **.GAMES**, **.VIDEO** or **.TAG**.

Delegate
--------

Most of the functionality that the view performs is executed internally and is
not exposed to the outside.
However there are cases where it's not wise to keep certain actions internal
so as to allow for more flexibility.

To this extent, the view provides a Delegate interface that it
uses to talk to the outside world. Any class (activity, fragment, etc) can
implement it.

.. code-block:: java

		interface IDetailFeedViewDelegate {

		    fun onClickUser(userId: String)

		    fun onClickFeedItem(feedItemId: String)

		    fun onClickHashTag(hashTag: String)

		    fun onClickRichMediaUnit(url: String, title: String, feedItemId: String, richId: String)

		    fun onAllowedToShare(feedItemId: String)

		    fun onNotAllowedToShare(countdownTimeInMilli: Long)

		    fun onShareSuccessful()
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    home_feed.setDelegate(some_object)
