Writing a comment
=================

**Summary**: Provides default UI for adding text comments.

Includes functionality to that allows a user to add text comments using an
input box.

Additionally it can allow a redirect to the **Art Tool** to enable adding
drawing type comments.

.. note::
    This view is linked with the **Comment** view. Adding a comment here will update the list of comments.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyFeedItemActivity">

      <tv.superawesome.pj.ui.input.CommentInput
        android:id="@+id/comment_input"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **CommentInput**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyFeedItemActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        comment_input.setSkin(CommentInputSkin())
        comment_input.setFeedItemId("__feed_item_id__")
        comment_input.bindTo(context.application.store)
      }

      override fun onDestroy() {
        comment_input.unbindFrom(context.application.store)
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

    interface ICommentInputViewDelegate {
      fun onKeyboardUp()
      fun onKeyboardDown()
      fun onClickCreateButton()
    }

To assign the view's delegate to some object that implements it:

.. code-block:: java

    comment_input.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

    // TBC 
