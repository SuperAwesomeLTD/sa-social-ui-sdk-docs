Displaying a Profile
====================

**Summary**: Provides default UI for a user's profile details.

Includes functionality to see the profile (avatar) image, background image,
number of followers, following count, etc.

Includes functionality to follow or unfollow a user (if it's not your own
user's profile) or to get followers (if it's your profile).

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyProfileActivity">

      <tv.superawesome.pj.ui.user.views.UserView
        android:id="@+id/user_profile"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **UserView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyProfileActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        user_profile.setSkin(UserSkin())
        user_profile.bindTo(context.application.store)
        user_profile.setUserId("__channel_or_user_id__")
        user_profile.fetchUser()
      }

      override fun onDestroy() {
        user_profile.unbindFrom(context.application.store)
        super.onDestroy()
      }
    }

And that's it!

.. note::
    Notice we have used Kotlin's **Kapt** extension in order to have direct access to the view via its ID. Good alternatives are Jake Wharton's `ButterKnife <http://jakewharton.github.io/butterknife/>`_ library or calling **findViewById** directly.

.. note::
    The **Search Results** view's **search** method can be hooked up to the **Search View** delegate method call **onSearchInputChanged**

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

		interface IUserViewDelegate {

		    fun onClickAvatar(userId: String)

		    fun onClickFollowingButton(userId: String)

		    fun onClickFollowersButton(userId: String)

		    fun onClickGetFollowersButton(userId: String)
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    user_profile.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

    interface IUserSkin : ISkin {
      val layout: Int
      val userIcon: Int
      val userName: Int
      val followButton: Int
      val getFollowersButton: Int
      val bio: Int
      val bgImage: Int
      val followers: Int
      val following: Int
      val creations: Int
    }
