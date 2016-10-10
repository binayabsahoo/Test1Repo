using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace CabForce
{
    public class EmailFormat
    {
        public string SendEmail(string toAddress, string subject, string body, System.Net.Mail.Attachment attachment = null)
        {
            string result = "Message Sent Successfully..!!";
            try
            {

                SmtpClient smtp = new SmtpClient
                {
                    Host = ConfigurationManager.AppSettings["Host"], // smtp server address here…
                    EnableSsl = bool.Parse(ConfigurationManager.AppSettings["enableSsl"]),
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["Email"], ConfigurationManager.AppSettings["Password"]),
                    Timeout = 30000,
                };
                if (ConfigurationManager.AppSettings["Port"] != null)
                {
                    smtp.Port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"]);
                }
                MailMessage message = new MailMessage(ConfigurationManager.AppSettings["Email"], toAddress, subject, body);
                message.CC.Add(ConfigurationManager.AppSettings["Email"]);
                message.IsBodyHtml = true;
                if (attachment != null)
                {
                    message.Attachments.Add(attachment);
                }
                smtp.Send(message);
            }
            catch (Exception ex)
            {
                result = "Error sending email.!!!";
            }
            return result;
        }
    }
}