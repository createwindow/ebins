/*********************************************************************
 * LEGAL DISCLAIMER
 *
 * (Header of FANVIL Software/Firmware Release or Documentation)
 *
 * BY OPENING OR USING THIS FILE, BUYER HEREBY UNEQUIVOCALLY 
 * ACKNOWLEDGES AND AGREES THAT THE SOFTWARE/FIRMWARE AND ITS 
 * DOCUMENTATIONS ("FANVIL SOFTWARE") RECEIVED FROM FANVIL AND/OR 
 * ITS REPRESENTATIVES ARE PROVIDED TO BUYER ON AN "AS-IS" BASIS ONLY. 
 * FANVIL EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR 
 * NONINFRINGEMENT. NEITHER DOES FANVIL PROVIDE ANY WARRANTY 
 * WHATSOEVER WITH RESPECT TO THE SOFTWARE OF ANY THIRD PARTY WHICH 
 * MAY BE USED BY, INCORPORATED IN, OR SUPPLIED WITH THE FANVIL 
 * SOFTWARE, AND BUYER AGREES TO LOOK ONLY TO SUCH THIRD PARTY FOR ANY
 * WARRANTY CLAIM RELATING THERETO. FANVIL SHALL ALSO NOT BE 
 * RESPONSIBLE FOR ANY FANVIL SOFTWARE RELEASES MADE TO BUYER'S 
 * SPECIFICATION OR TO CONFORM TO A PARTICULAR STANDARD OR OPEN FORUM.
 *
 * BUYER'S SOLE AND EXCLUSIVE REMEDY AND FANVIL'S ENTIRE AND 
 * CUMULATIVE LIABILITY WITH RESPECT TO THE FANVIL SOFTWARE RELEASED 
 * HEREUNDER WILL BE, AT FANVIL'S OPTION, TO REVISE OR REPLACE THE 
 * FANVIL SOFTWARE AT ISSUE, OR REFUND ANY SOFTWARE LICENSE FEES OR 
 * SERVICE CHARGE PAID BY BUYER TO FANVIL FOR SUCH FANVIL SOFTWARE
 * AT ISSUE.
 *
 * THE TRANSACTION CONTEMPLATED HEREUNDER SHALL BE CONSTRUED IN 
 * ACCORDANCE WITH THE LAWS OF THE STATE OF CALIFORNIA, USA, EXCLUDING
 * ITS CONFLICT OF LAWS PRINCIPLES.
 **********************************************************************
 */

/*
 *  Filename:  offset.c
 *
 *  Author:  yiguo 
 *
 *  Last Revision Date:  2013年07月08日 13时38分33秒
 *
 *  Description:  calculate offsets between the memcheck address
 *    and the process memory mapped address
 *    argv[1]: the base address 
 *    argv[2...n]:  memcheck addresses
 *
 */

#include <stdio.h>
#define BIN_BASE_ADDR (0x)

/* Note: convert a string to a long int
 * return values: 
 * -1, if @str is invalid: the converted number not located in 
 *   [@lower_limit, @upper_limit] (@upper_limit == -1 means no limit) 
 *   or @str is NOT a digital string. 
 * 0,  if @str is valid. */
static int _strtol(const char *str, int lower_limit, int upper_limit, 
    long int *converted)
{
    char *endptr;
    long int num;
    int ret = -1;

    if (str && converted)
    {
        num = strtol(str, &endptr, 16);
        if (*endptr == '\0' && (lower_limit == -1 || num >= lower_limit) && 
            (upper_limit == -1 || num <= upper_limit))
        {
            *converted = num;
            ret = 0;
        }
        else
        {
            fprintf(stderr, "_strtol(): argument(%s) error!", str);
        }
    }
 
    return ret;
}

int main(int argc, char **argv)
{
    int i; 
    for (i = 1; i < argc; ++i)
    {
        long int converted, base_addr, offset;
        _strtol(argv[i], 0, -1, &converted);

//        printf("0x%lx ", converted);
        if (i == 1)
        {
            base_addr = converted;
        }
        else
        {
            if ((offset = converted - base_addr) >= 0)
            {
                printf("%lx ", offset);
            }
            else
            {
                printf("Address NOT in the range!\n");
            }
        }
    }
    printf("\n");

    return 0;
}

