Setup
=====

Before we are able to use the SDK we must set it up correctly.

First thing to do is to define an environment to work with:

.. code-block:: java

    /**
     * Our custom environment class implements the INetworkEnvironment
     * interface.
     * The only thing we must define is the specific server instance
     * we want to connect to.
     */
    class MyEnvironment: INetworkEnvironment {
      override val environment = "https://my.server.instance.com"
    }

Next it's a matter of creating and configuring up some essential SDK components.
As in many other cases, this involves doing work in a custom application class.

.. code-block:: java

    class MyApplication: Application() {

      /**
       * Fist, create an instance of the environment type we defined previously
       */
      val environment = MyEnvironment()

      /**
       * Second, we create a Store. This holds as well as mutates all
       * the internal state of the SDK.
       */
      val store = Store()

      override fun onCreate() {
        super.onCreate()

        /**
         * We can then obtain an instance of SharedPreferences to keep all
         * non-transient data in.
         */
        val preferences = PreferenceManager.getDefaultSharedPreferences(this)

        /**
         * Next we create an instance of an "SDK", that we feed the
         * current context as well as the environment.
         * This will configure all internal services.
         */
        val sdk = SocialSDK(this, environment)

        /**
         * Finally, we use the previous store, sdk instance and
         * SharedPreferences instance to configure the Social SDK.
         */
        DispatchFactory.configure(store, sdk, preferences)
      }
    }

And that's it!
All of the internal SDK components are now correctly configured.

Additionally, know that we will need to use the Store we defined in a number
of cases in the codebase.

It's therefore indicated that we use Kotlin's powerful extension mechanism to
create a method to help us access it easily.

.. code-block:: java

    val Application.store: Store
      get() {
        return (this as MyApplication).store
      }
