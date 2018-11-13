Selecting an avatar
===================

**Summary**: Provides default UI for selecting or updating an avatar.

Includes functionality that displays avatars (or "stickers") as a 4xN grid
that users can select from and update their avatar image.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyIntroActivity">

      <tv.superawesome.pj.ui.selectavatar.view.SelectAvatarView
        android:id="@+id/select_avatar"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **SelectAvatarView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyIntroActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        select_avatar.setSkin(SelectAvatarViewSkin())
        select_avatar.bindTo(context.application.store)
        select_avatar.fetchAvatars()
      }

      override fun onDestroy() {
        select_avatar.unbindFrom(context.application.store)
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

    interface ISelectAvatarViewDelegate {
      fun onClickCreateAvatar()
      fun onAvatarUpdate()
    }

To assign the view's delegate to some object that implements it:

.. code-block:: java

    select_avatar.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

		interface ISelectAvatarViewSkin : ISkin {
		    val layout: Int
		    val createAvatarButton: Int?
		    val okButton: Int
		    val okButtonContainer: Int
		}
