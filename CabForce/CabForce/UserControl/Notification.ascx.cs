using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CabForce
{
    public enum NotificationTypes
    {
        Warning,
        Information,
        Success,
        Failure,
        LightBulb,
        Messages
    }

    public partial class Notification : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void ShowNotification(NotificationTypes notificationType, string header, string message)
        {
            panNotification.CssClass = string.Format("notification {0} canhide", notificationType).ToLower();

            if (!string.IsNullOrEmpty(header))
                litNotificationHeader.Text = header + ":";
            else
                litNotificationHeader.Text = string.Empty;

            litMessage.Text = message;
            panNotification.Style.Add("display", "block");

            this.Visible = true;
        }

        public void ShowNotification(NotificationTypes notificationType, string message)
        {
            panNotification.CssClass = string.Format("notification {0} canhide", notificationType).ToLower();
            litNotificationHeader.Text = notificationType.ToString().ToUpper() + ":";
            litMessage.Text = message;
            panNotification.Style.Add("display", "block");

            this.Visible = true;
        }

        public void AppendNotificationText(NotificationTypes notificationType, string message)
        {
            ShowNotification(notificationType, litMessage.Text += message);
        }
    }
}