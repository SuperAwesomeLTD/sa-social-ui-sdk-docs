Displaying Comments
===================

**Summary**: Provides functionality to like and reply to comments,
and to report comments to moderators.

Provides support for text, image and “sticker” comments.


...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyFeedItemActivity">

      <tv.superawesome.pj.ui.comments.views.CommentView
        android:id="@+id/comments"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **CommentView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyFeedItemActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        comments.setSkin(CommentViewSkin()())
        comments.bindTo(context.application.store)
        comments.setFeedItemId("__feed_item_id__")
        comments.fetchComments()
      }

      override fun onDestroy() {
        comments.unbindFrom(context.application.store)
        super.onDestroy()
      }
    }

And that's it!

.. note::
    Notice we have used Kotlin's **Kapt** extension in order to have direct access to the view via its ID. Good alternatives are Jake Wharton's `ButterKnife <http://jakewharton.github.io/butterknife/>`_ library or calling **findViewById** directly.

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

		interface ICommentViewDelegate {

		    fun onClickUser(userId: String)

		    fun onClickHashTag(hashTag: String)

		    fun onClickFeedItem(feedItemId: String, base64Image: String)
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    comments.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

    // TBC 
