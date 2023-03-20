// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import * as echarts from "echarts";
import "echarts/theme/dark";
//= require echarts.min.js
//= require echarts/theme/dark.js
window.echarts = echarts;
