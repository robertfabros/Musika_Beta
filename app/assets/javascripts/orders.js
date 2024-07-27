// app/assets/javascripts/orders.js
document.addEventListener("DOMContentLoaded", function() {
    const provinceSelect = document.getElementById("order_province_id");
  
    const calculateTaxes = function() {
      const provinceId = provinceSelect.value;
      fetch(`/provinces/${provinceId}/taxes`)
        .then(response => response.json())
        .then(data => {
          const gstRate = data.gst;
          const pstRate = data.pst;
          const qstRate = data.qst;
          const hstRate = data.hst;
  
          const subtotal = parseFloat(document.getElementById("subtotal").dataset.value);
          const gst = subtotal * gstRate;
          const pst = subtotal * pstRate;
          const qst = subtotal * qstRate;
          const hst = subtotal * hstRate;
          const total = subtotal + gst + pst + qst + hst;
  
          document.getElementById("gst").textContent = gst.toFixed(2);
          document.getElementById("pst").textContent = pst.toFixed(2);
          document.getElementById("qst").textContent = qst.toFixed(2);
          document.getElementById("hst").textContent = hst.toFixed(2);
          document.getElementById("total").textContent = total.toFixed(2);
        });
    };
  
    if (provinceSelect) {
      provinceSelect.addEventListener("change", calculateTaxes);
      calculateTaxes(); // Trigger calculation on page load
    }
  });
  