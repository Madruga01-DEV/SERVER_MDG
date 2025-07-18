const { createApp } = Vue;
createApp({
  data() {
    return {
      message: "",
      visible: false,
      theme: null,
      time: 0,
      currenttime: 0,
      interval: null,
      timeout: null,
      running: false,
      maincolor: null,
      width: "20vw",
      cancelled: false,
    };
  },
  mounted() {
    window.addEventListener("message", this.onMessage);
  },
  destroyed() {
    // Clean up resources when app is hidden/destroyed
    window.removeEventListener("message");

    if (this.interval) clearInterval(this.interval);
    if (this.timeout) clearTimeout(this.timeout);
  },
  computed: {
    counter() {
      return Math.trunc((this.time - this.currenttime) / 1000);
    },
  },
  methods: {
    onMessage(event) {
      if (event.data.type === "vp-open") {
        this.visible = true;
        this.message = event.data.message;
        this.theme = event.data.theme;
        this.time = event.data.mili;
        this.maincolor = event.data.color;
        this.width = event.data.width;
        this.cancelled = false;
        let that = this;
        running = true;

        this.interval = setInterval(() => {
          that.currenttime += 1000;
        }, 1000);

        this.timeout = setTimeout(() => {
          that.running = false;
          that.visible = false;
          clearInterval(that.interval);
          that.currenttime = 0;
          that.interval = null;
          that.timeout = null;
          if (!this.cancelled) {
            fetch(`https://${GetParentResourceName()}/ProgressFinished`, {
              method: "POST",
            });
          }
        }, event.data.mili);
      }
      if (event.data.type === "vp-cancel") {
        this.cancelled = true;
        this.running = false;
        this.visible = false;
        clearInterval(this.interval);
        this.currenttime = 0;
        this.interval = null;
        this.timeout = null;
      }
    },
  },
}).mount("#app");
