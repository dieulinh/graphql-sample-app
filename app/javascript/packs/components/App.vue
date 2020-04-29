<template>
  <div>
    <div class="top-menu">
      <div class="sc-eAKXzc fsQCvb">
        <div class="sc-cqpYsc fyGxwu">
          <div class="sc-hBbWxd jrHWGb">
          </div>
          <div>
            <a class="brand" href="/">Classr0Om</a>
          </div>
        </div>
      </div>
      <div class="sc-bfYoXt bWIgkI">
        <div class="sc-gbOuXE grYNdw">
          <div class="sc-cTjmhe lnntkT">
            <p class="sc-iAyFgw sc-hSdWYo sc-fnwBNb fPkGxY">Search</p>
          </div>
        </div>
        <div class="sc-dxZgTM khUrnx">
          <div class="NotificationContainer_NotificationContainerWrapper-sc-bb4fan kMXxed">
            <span
              class="tooltip-container NotificationContainer_NotificationTooltipWrapper-sc-1jdjwer bEGeae"
              data-tooltip="Notifications"
            >
              <div class="NotificationIcon_NotificationIconWrapper-sc-3rbk7d dBubSX">
                <div class="NotificationIcon_NotificationIconIcon-sc-wpy2fb kHpsUH">
                  <span name="bell" class="fa fa-bell"></span>
                </div>
              </div>
            </span>
            <div></div>
          </div>
          <div class="sc-iomxrj coXyqt">
            <span
              title
              class="rmwc-icon google-material-icons mdc-ripple-upgraded mdc-ripple-surface rmwc-avatar rmwc-avatar--large rmwc-avatar--interactive rmwc-avatar--has-image"
            >
              <div
                class="rmwc-avatar__icon"
                style="background-image: url(&quot;https://storage.googleapis.com/kaggle-avatars/thumbnails/default-thumb.png&quot;); background-size: cover;"
              ></div>
              <div class="rmwc-avatar__text">
                <div class="rmwc-avatar__text-inner"></div>
              </div>
            </span>
            <div class="mdc-menu-surface--anchor">
              <div
                aria-hidden="true"
                class="mdc-menu sc-eTpRJs bLfhhF sc-dvCyap kAQTwa mdc-menu-surface"
                style="transform-origin: center top; left: 0px; top: 0px; max-height: 586.5px;"
              >
                <div role="menu" class="mdc-list mdc-menu__items mdc-list">
                  <p class="sc-iFMziU YQKYs">Signed in as Someone </p>
                  <a href="/linhdev2019" class="sc-gVLVqr sc-cBdUnI SaoYz">
                    <div
                      role="menuitem"
                      tabindex="0"
                      class="sc-keVrkP bjGZgO mdc-ripple-upgraded sc-keVrkP bjGZgO mdc-list-item"
                    >My Profile</div>
                  </a>
                  <a href="/linhdev2019/account" class="sc-gVLVqr sc-cBdUnI SaoYz">
                    <div
                      role="menuitem"
                      tabindex="0"
                      class="sc-keVrkP bjGZgO mdc-ripple-upgraded sc-keVrkP bjGZgO mdc-list-item"
                    >My Account</div>
                  </a>
                  <a href="/account/logoff" class="sc-gVLVqr sc-cBdUnI SaoYz">
                    <div
                      role="menuitem"
                      tabindex="0"
                      class="sc-keVrkP bjGZgO mdc-ripple-upgraded sc-keVrkP bjGZgO mdc-list-item"
                    >Sign Out</div>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="main">
      <router-view />
    </div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      message: "Hello Vue!"
    };
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
